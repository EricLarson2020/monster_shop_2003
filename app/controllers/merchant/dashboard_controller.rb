class  Merchant::DashboardController < ApplicationController

   before_action :require_merchant

  # before_action :require_merchant

  def show
    @merchant = current_user.merchant
  end

  def index

    @merchant = current_user.merchant


  end

  private
    def require_merchant
     render file: "/public/404" unless current_merchant?
   end

end
