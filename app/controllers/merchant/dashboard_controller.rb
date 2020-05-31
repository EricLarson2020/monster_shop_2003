class  Merchant::DashboardController < ApplicationController 
  # before_action :require_merchant
  def show
        @merchant = current_user.merchant

  end 

  def index
    # binding.pry
    @merchant = current_user.merchant
  end

end 