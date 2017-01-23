class Admin::UsersController < AdminController
  load_and_authorize_resource :user

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(params[:user].permit!)
      flash[:notice] = "Account updated!"
      redirect_to admin_users_path
    else
      render action: :edit
    end
  end
end