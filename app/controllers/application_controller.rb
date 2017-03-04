class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = exception.message
    redirect_to current_user ? calendar_path : signin_path
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper :all
  helper_method :current_user_session, :current_user
  # filter_parameter_logging :password, :password_confirmation

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_no_user
    if current_user
      store_location
      flash[:danger] = "You must be logged out to access this page"
      redirect_to calendar_path
      return false
    end
  end

  def store_location
    session[:return_to] = request.original_url
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def signed_in_user
    unless current_user
      store_location
      flash[:danger] = "Please sign in to continue"
      redirect_to signin_path
    end
  end

  def signed_in_admin_user
    if current_user && !current_user.admin?
      redirect_to root_path
    elsif !current_user
      store_location
      redirect_to signin_path
    end
  end
end
