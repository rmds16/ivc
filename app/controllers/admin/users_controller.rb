class Admin::UsersController < AdminController
  load_and_authorize_resource :user

  def new
    @user = User.new
  end

  def index
    @users = User.order(:surname, :first_name).paginate(page: params[:page], per_page: 10)
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Account updated!"
      redirect_to admin_users_path
    else
      render action: :edit
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Account registered!"
      redirect_back_or_default admin_users_path
    else
      render action: :new
    end
  end

  private
 
  def user_params
    params.require(:user).permit(:first_name, :surname, :email, :password, :password_confirmation, :admin)
  end
end