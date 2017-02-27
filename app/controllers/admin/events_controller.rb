class Admin::EventsController < AdminController
  load_and_authorize_resource :event

  def new
    @organisers = User.organisers
    @event = Event.new
    @event.organiser_id = current_user.id
    @event.organiser_email = current_user.email
    @event.organiser_phone = current_user.phone
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def index
    @events = Event.order(start_date: :desc).paginate(page: params[:page], per_page: 10)
  end

  def edit
    @organisers = User.organisers
    @event = Event.find_by(id: params[:id])
  end

  def update
    @event = Event.find_by(id: params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = "Event updated!"
      redirect_to admin_events_path
    else
      @organisers = User.organisers
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
    if @event.save
      flash[:success] = "Event created!"
      redirect_back_or_default admin_events_path
    else
      @organisers = User.organisers
      render action: :new
    end
  end

  def leave
    @event = Event.find_by(id: params[:event_id])
    user = User.find_by(id: params[:user_id])

    unless @event.attendees.include?(user)
      flash[:success] = "#{user.full_name} has already unsubscribed from this event"
      redirect_to event_path(@event)
      return
    end

    flash[:danger] = "An error has occurred, unable to unsubscribe from event" unless @event.attendees.delete(user)
    
    redirect_to admin_event_path(@event)
  end

  private

  def event_params
    params.require(:event).permit(:title, :start_date, :public_description, :where, :post_map_ref, :organiser_id, :organiser_email, :organiser_phone, :second_organiser_id, :second_organiser_email, :second_organiser_phone, :book_by_date, :featured_event)
  end
end