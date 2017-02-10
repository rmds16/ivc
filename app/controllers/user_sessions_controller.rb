class UserSessionsController < ApplicationController
  load_and_authorize_resource
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(user_session_params)
    if @user_session.save
      flash[:success] = "Login successful!"
      redirect_back_or_default calendar_path
    else
      render action: :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:success] = "Logout successful!"
    redirect_back_or_default new_user_session_path
  end

  private

  def user_session_params
    params.require(:user_session).permit(:email, :password, :remember_me)
  end
end
