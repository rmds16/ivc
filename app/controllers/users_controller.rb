class UsersController < ApplicationController
  load_and_authorize_resource
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user].permit!)
    if @user.save!
      flash[:notice] = "Account registered!"
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
    if @user.update_attributes(params[:user].permit!)
      flash[:notice] = "Account updated!"
      redirect_to calendar_path
    else
      render action: :edit
    end
  end
end