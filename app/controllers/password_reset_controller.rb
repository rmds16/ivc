class PasswordResetController < ApplicationController
  before_action :require_no_user
  before_action :load_user_using_perishable_token, :only => [ :edit, :update ]

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:success] = "Instructions to reset your password have been emailed to you"
      redirect_to root_path
    else
      flash.now[:danger] = "No user was found with email address #{params[:email]}"
      render action: :new
    end
  end

  def edit
  end

  def update
    unless params[:password].present? && params[:password_confirmation].present?
  	  flash[:danger] = "Please enter a new password and password confirmation"
  	  render action: :edit
  	  return
  	end

  	if params[:password] != params[:password_confirmation]
  	  flash[:danger] = "Your password confirmation does not match your password"
  	  render action: :edit
  	  return
  	end

  	@user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]

    if @user.save
      flash[:success] = "Your password was successfully updated"
      redirect_to calendar_path
    else
      render action: :edit
    end
  end

  private

  def load_user_using_perishable_token
    @user = User.find_by(perishable_token: params[:id])
    unless @user
      flash[:danger] = "We're sorry, but we could not locate your account"
      redirect_to signin_path
    end
  end
end
