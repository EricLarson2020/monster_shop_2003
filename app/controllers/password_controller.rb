class PasswordController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(password_params)

    if password_params[:password] != password_params[:password_confirmation]
      flash[:error] = "Password and confirmation must match"
      redirect_to "/password/#{@user.id}/edit"
    elsif @user.save
      redirect_to '/profile'
      flash[:success] = "Your password has been updated"
    else
      flash[:error] = "You are missing required fields"
      redirect_to "/password/#{@user.id}/edit"
    end
  end

  private

  def password_params
    params.permit(:password, :password_confirmation)
  end
end