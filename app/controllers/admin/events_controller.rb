class Admin::EventsController < AdminController
  load_and_authorize_resource :event

  def new
    @event = Event.new
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def index
    @events = Event.order(start_date: :desc).paginate(page: params[:page], per_page: 10)
  end

  def edit
    @event = Event.find_by(id: params[:id])
  end

  def update
    @event = Event.find_by(id: params[:id])
    if @event.update_attributes(event_params)
      flash[:notice] = "Event updated!"
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
      flash[:notice] = "Event created!"
      redirect_back_or_default admin_event_path
    else
      render action: :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :start_date, :end_date, :public_description, :venue_web_link, :organiser, :book_by_date, :featured_event)
  end
end