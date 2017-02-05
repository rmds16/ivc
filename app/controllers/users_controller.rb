class UsersController < ApplicationController
  load_and_authorize_resource
  before_filter :signed_in_user
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save!
      flash[:success] = "Account registered!"
      redirect_back_or_default calendar_path
    else
      render action: :new
    end
  end
  
  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(user_params)
      flash[:success] = "Account updated!"
      redirect_to calendar_path
    else
      render action: :edit
    end
  end

  def user_details
    render json: User.find_by(id: params[:user_id]).to_json
  end

  private
 
  def user_params
    params.require(:user).permit(:first_name, :surname, :email, :password, :password_confirmation)
  end
end