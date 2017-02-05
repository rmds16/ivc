class Admin::EventsController < AdminController
  load_and_authorize_resource :event

  def new
    @organisers = User.all.map { |u| [u.full_name, u.id] }
    @event = Event.new
    @event.organiser = current_user.id
    @event.organiser_email = current_user.email
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def index
    @events = Event.order(start_date: :desc).paginate(page: params[:page], per_page: 10)
  end

  def edit
    @organisers = User.all.map { |u| [u.full_name, u.id] }
    @event = Event.find_by(id: params[:id])
  end

  def update
    @event = Event.find_by(id: params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = "Event updated!"
      redirect_to admin_events_path
    else
      render action: :edit
    end
  end

  def destroy
    event = Event.find_by(id: params['id'])
    event.destroy if event
    redirect_to admin_events_path
  end

  def create
    @event = Event.new(event_params)
    if @event.save!
      flash[:success] = "Event created!"
      redirect_back_or_default admin_event_path
    else
      render action: :new
    end
  end

  def leave
    @event = Event.find_by(id: params[:event_id])
    user = User.find_by(id: params[:user_id])

    unless @event.attendees.include?(user)
      flash[:success] = "#{user.fullname} has already unsubscribed from this event"
      redirect_to event_path(@event)
      return
    end

    flash[:danger] = "An error has occurred, unable to unsubscribe from event" unless @event.attendees.delete(user)
    
    redirect_to admin_event_path(@event)
  end

  private

  def event_params
    params.require(:event).permit(:title, :start_date, :end_date, :public_description, :venue_web_link, :organiser, :book_by_date, :featured_event)
  end
end