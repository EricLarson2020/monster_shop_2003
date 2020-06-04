class ProfileController < ApplicationController

  before_action :require_user

  def index
    # binding.pry
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)

    if @user.save
      flash[:notice] = "Your profile has been updated"
      redirect_to "/profile"
    else
      flash[:notice] = @user.errors.full_messages.to_s
      redirect_to "/profile/#{@user.id}/edit"
    end
  end

  private

  def require_user
   render file: "/public/404" unless current_user
  end

  def user_params
    params.permit(:name, :email, :address, :city, :state, :zip)
  end
end
