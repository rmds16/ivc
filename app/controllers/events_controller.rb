class EventsController < ApplicationController
  load_and_authorize_resource
  before_filter :signed_in_user, except: :index

  def new
    @organisers = User.all.map { |u| [u.full_name, u.id] }
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
    @event.start_date = DateTime.parse(event_params[:start_date])
    @event.end_date = @event.start_date + 1.hour
    if @event.save!
      flash[:success] = "Event created!"
      redirect_back_or_default calendar_path
    else
      render action: :new
    end
  end
  
  def show
    @event = Event.find_by(id: params[:id])
  end

  def edit
    @organisers = User.all.map { |u| [u.full_name, u.id] }
    @event = Event.find_by(id: params[:id])
  end
  
  def update
    @event = Event.find_by(id: params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = "Event updated!"
      redirect_to calendar_path
    else
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

    flash[:danger] =attendees "An error has occurred, unable to subscribe to event" unless @event.attendees << current_user
    
    UserMailer.welcome_email(current_user, @event).deliver_now

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
    
    redirect_to event_path(@event)
  end

  private

  def event_params
    params.require(:event).permit(:title, :start_date, :public_description, :where, :post_map_ref, :organiser_id, :organiser_email, :organiser_phone, :second_organiser_id, :second_organiser_email, :second_organiser_phone, :book_by_date, :featured_event)
  end
end