class Admin::EventsController < AdminController
  load_and_authorize_resource :event

  def index
    @events = Event.paginate(page: params[:page], per_page: 10)
  end

  def edit
    @event = Event.find_by(id: params[:id])
  end

  def update
    @event = Event.find_by(id: params[:id])
    if @event.update_attributes(params[:event].permit!)
      flash[:notice] = "Event updated!"
      redirect_to admin_events_path
    else
      render action: :edit
    end
  end
end