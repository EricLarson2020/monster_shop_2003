class SessionsController < ApplicationController
  def new
# binding.pry
    if current_user
      # current_user = User.find_by(id: session[:user_id])
      flash[:notice] = "You are already logged in"

      if current_admin?
        redirect_to "/admin/dashboard"
      elsif current_user.merchant?
        redirect_to "/merchant/dashboard"
      else
        redirect_to "/profile"
      end
    end
  end

    def create
# binding.pry
      if User.find_by(email: params[:email])
        user = User.find_by(email: params[:email])
        # binding.pry
        session[:user_id] = user.id
        if user.authenticate(params[:password]) && user.role == "admin"
            flash[:notice] = "You are logged in as #{user.name}"
            redirect_to "/admin/dashboard"
        elsif user.authenticate(params[:password]) && user.role == "merchant"
            flash[:notice] = "You are logged in as #{user.name}"
            redirect_to "/merchant/dashboard"
        elsif user.authenticate(params[:password]) && user.role == "default"
            flash[:notice] = "You are logged in as #{user.name}"
            redirect_to "/profile"
        else
            flash[:error] = "Sorry, your credentials are bad."
            render :new

        end
      else
        flash[:error] = "Sorry, your credentials are bad."
        render :new
      end
    end
end
