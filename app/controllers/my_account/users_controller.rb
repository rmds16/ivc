class MyAccount::UsersController < MyAccountController
  load_and_authorize_resource :user

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user].permit!)
      flash[:success] = "Account updated!"
      redirect_to my_account_user_path(@user)
    else
      render action: :edit
    end
  end
end