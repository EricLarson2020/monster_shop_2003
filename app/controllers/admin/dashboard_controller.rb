class Admin::DashboardController < ApplicationController

    def show
      @admin = current_user
      @users = User.all
    end

end
