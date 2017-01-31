class MyAccount::EventsController < MyAccountController

  def index
    @events = current_user.future_events.paginate(page: params[:page], per_page: 10)
  end

end