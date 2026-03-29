class UsersController < ApplicationController

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if current_user.update_with_password(user_params)
      bypass_sign_in(current_user)
      redirect_to root_path, notice: t('users.updated', default: 'Профиль обновлён.')
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end

end
