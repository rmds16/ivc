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

    unless @event.attendees.include?(user)
      flash[:success] = "#{user.full_name} has already unsubscribed from this event"
      redirect_to event_path(@event)
      return
    end

    flash[:danger] = "An error has occurred, unable to unsubscribe from event" unless @event.attendees.delete(user)
    
    redirect_to event_path(@event)
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