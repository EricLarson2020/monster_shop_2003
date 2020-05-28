class PasswordController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(password_params)

    if  @user.save
    redirect_to '/profile'
      flash[:notice] = "Your password has been updated"
    elsif password_params[:password] != password_params[:password_confirmation]
      flash[:notice] = "Password and password confirmation must match"
      redirect_to "/password/#{@user.id}/edit"
    else
      flash[:notice] = "You are missing required fields."
      redirect_to "/password/#{@user.id}/edit"
    end
  end

  private

  def password_params
    params.permit(:password, :password_confirmation)
  end
end