class SessionsController < ApplicationController
    def new 
    end 

    def create 
        user = User.find_by(params[:id])
        # binding.pry
        session[:user_id] = user.id
        if user.role == "admin" 
            flash[:notice] = "You are logged in as #{user.name}"
            redirect_to "/admin/dashboard"
        elsif user.role == "merchant"
            flash[:notice] = "You are logged in as #{user.name}"
            redirect_to "/merchant/dashboard"
        else 
            flash[:notice] = "You are logged in as #{user.name}"
            redirect_to "/profile"
        end 
    end 
end 