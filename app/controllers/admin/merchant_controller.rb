class Admin::MerchantController < ApplicationController
  before_action :require_admin

  def show
    # binding.pry
    @merchant = Merchant.find(params[:id])
  end

  def index
    @merchant = Merchant.all
  end

  def update

    merchant = Merchant.find(params[:id])
    merchant.status = "disabled"
    merchant.update(disable_merchant)
    merchant.save
    flash[:notice] = "You have disable merchant #{merchant.id}"
    redirect_to "/admin/merchants"
  end

  private

    def disable_merchant
      params.permit(:status)
    end

    def require_admin
      render file: "/public/404" unless current_admin?
    end
end
