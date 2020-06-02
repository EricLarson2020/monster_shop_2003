class Admin::MerchantController < ApplicationController
  before_action :require_admin

  def show
    # binding.pry
    @merchant = Merchant.find(params[:id])
  end

  def index
    @merchant = Merchant.all
  end

  private
    def require_admin
      render file: "/public/404" unless current_admin?
    end
end
