class MyAccount::EventsController < MyAccountController

  def index
    @events = current_user.attended_events.paginate(page: params[:page], per_page: 10)
  end

  def show
    @event = Event.find params[:id]
  end

  def destroy
    event = Event.find params[:id]
    if event && current_user.attended_events.delete(event)
      flash[:notice] = "Event removed!"
    end
    redirect_to my_account_events_path
  end
end