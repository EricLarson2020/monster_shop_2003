class SessionsController < ApplicationController
    def new
    end

    def create

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
