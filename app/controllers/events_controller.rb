class EventsController < ApplicationController
  load_and_authorize_resource
  before_filter :signed_in_user, except: :index

  def new
    @organisers = User.organisers
    @event = Event.new
    @event.organiser_id = current_user.id
    @event.organiser_email = current_user.email
    @event.organiser_phone = current_user.phone
    if params['date']
      @event.start_date = Date.parse(params['date']) 
      @event.end_date = Date.parse(params['date'])
    end
  end

  def index
    return [] unless params['start'] && params['end']

    start_date = Date.parse(params['start'])
    end_date = Date.parse(params['end'])

    render json: Event.where(start_date: start_date..end_date).to_json(current_user)
  end

  def create
    @event = Event.new(event_params)
    @event.start_date = DateTime.parse(event_params[:start_date]) if params[:start_date]
    @event.end_date = @event.start_date + 1.hour if @event.start_date
    @event.user = current_user
    if @event.save
      flash[:success] = "Event created!"
      redirect_back_or_default calendar_path
    else
      @organisers = User.organisers
      render action: :new
    end
  end
  
  def show
    @event = Event.find_by(id: params[:id])
    @days = []
    Date::DAYNAMES.each_with_index { |x, i| @days << [x, i] }
  end

  def edit
    @organisers = User.organisers
    @event = Event.find_by(id: params[:id])
  end
  
  def update
    @event = Event.find_by(id: params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = "Event updated!"
      redirect_to calendar_path
    else
      @organisers = User.organisers
      render action: :edit
    end
  end

  def signup
    @event = Event.find_by(id: params[:event_id])

    if @event.attendees.include?(current_user)
      flash[:success] = "You are already subscribed to this event"
      redirect_to event_path(@event)
      return
    end

    flash[:danger] = attendees "An error has occurred, unable to subscribe to event" unless @event.attendees << current_user
    
    UserMailer.event_signup(current_user, @event).deliver_now
    UserMailer.organiser_event_signup(@event.organiser, current_user, @event).deliver_now if @event.organiser
    UserMailer.organiser_event_signup(@event.second_organiser, current_user, @event).deliver_now if @event.second_organiser


    redirect_to event_path(@event)
  end

  def destroy
    event = Event.find_by(id: params['id'])
    event.destroy if event
    redirect_to calendar_path
  end

  def leave
    @event = Event.find_by(id: params[:event_id])

    unless @event.attendees.include?(current_user)
      flash[:success] = "You are already unsubscribed from this event"
      redirect_to event_path(@event)
      return
    end

    flash[:danger] = "An error has occurred, unable to unsubscribe from event" unless @event.attendees.delete(current_user)

    UserMailer.event_leave(current_user, @event).deliver_now
    UserMailer.organiser_event_leave(@event.organiser, current_user, @event).deliver_now if @event.organiser
    UserMailer.organiser_event_leave(@event.second_organiser, current_user, @event).deliver_now if @event.second_organiser

    redirect_to event_path(@event)
  end

  def remove_attendee
    @event = Event.find_by(id: params[:event_id])
    user = User.find_by(id: params[:user_id])

    unless @event.user_authorised?(current_user)
      raise CanCan::AccessDenied.new("Not authorized!", :remove_attendee, Event)
    end

    unless @event.attendees.include?(user)
      flash[:success] = "#{user.full_name} has already unsubscribed from this event"
      redirect_to event_path(@event)
      return
    end

    flash[:danger] = "An error has occurred, unable to unsubscribe from event" unless @event.attendees.delete(user)
    
    redirect_to event_path(@event)
  end

  def repeat_once
    begin
      @event = Event.find_by(params[:event_id])
      repeat_event = @event.dup
      repeat_event.update_attributes(event_params)
      repeat_event.update_attribute(:end_date, repeat_event.start_date + 1.hour) if repeat_event.start_date
      days_diff = (repeat_event.start_date.to_date - @event.start_date.to_date).to_i
      repeat_event.update_attribute(:book_by_date, @event.book_by_date + days_diff.days) if @event.book_by_date
      redirect_to calendar_path
    rescue
      flash[:danger] = "An error occured, please try again"
      render action: :show
    end 
  end

  def repeat_weekly
    begin
      @event = Event.find_by(params[:event_id])

      start_date = DateTime.new(params['weekly_start_date']['year'].to_i, params['weekly_start_date']['month'].to_i, params['weekly_start_date']['day'].to_i, params['weekly_start_time']['hour'].to_i, params['weekly_start_time']['minute'].to_i)
      end_date = DateTime.new(params['weekly_end_date']['year'].to_i, params['weekly_end_date']['month'].to_i, params['weekly_end_date']['day'].to_i, params['weekly_start_time']['hour'].to_i, params['weekly_start_time']['minute'].to_i)

      if(start_date > end_date) || (end_date < DateTime.now)
        flash[:danger] = "Invalid date range"
        render action: :show
        return
      end

      new_date = (end_date - end_date.wday.days) + params[:day_of_week].to_i.days   
      new_date -= 7.days if new_date > end_date

      while (new_date > DateTime.now) && (new_date >= start_date)
        new_event = @event.dup
        days_diff = (new_date.to_date - @event.start_date.to_date).to_i
        new_event.update_attributes(start_date: new_date, end_date: new_date + 1.hour)
        new_event.update_attribute(:book_by_date, @event.book_by_date + days_diff.days) if @event.book_by_date
        new_date -= 7.days
      end
      redirect_to calendar_path
    rescue
      flash[:danger] = "An error occured, please try again"
      redirect_to calendar_path
    end
  end

  def search_event
    @start_date = DateTime.now
    @end_date = DateTime.now + 7.days

    if params['start_date(3i)'].present? && params['end_date(3i)'].present?
      begin
        @start_date = Date.civil(params['start_date(1i)'].to_i, params['start_date(2i)'].to_i, params['start_date(3i)'].to_i)
        @end_date = Date.civil(params['end_date(1i)'].to_i, params['end_date(2i)'].to_i, params['end_date(3i)'].to_i)
      rescue => e
        flash[:danger] = "Please enter a valid date range"
        @events = Event.where("start_date > ? && start_date < ?", @start_date, @end_date).order(:start_date)
        respond_to do |format|
          format.html
          format.pdf do
            redirect_to search_event_events_path
          end
        end
        return
      end
    end

    @start_date = @start_date.beginning_of_day
    @end_date = @end_date.end_of_day

    if @start_date.to_date > @end_date.to_date
      flash[:danger] = "Please enter a valid date range"
      @events = Event.where("start_date > ? && start_date < ?", @start_date, @end_date).order(:start_date)
      respond_to do |format|
        format.html
        format.pdf do
          redirect_to search_event_events_path
        end
      end
      return
    end

    @events = Event.where("start_date > ? && start_date < ?", @start_date, @end_date).order(:start_date)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "ivc_events"
      end
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :start_date, :public_description, :where, :post_map_ref, :organiser_id, :organiser_email, :organiser_phone, :second_organiser_id, :second_organiser_email, :second_organiser_phone, :book_by_date, :featured_event)
  end
end