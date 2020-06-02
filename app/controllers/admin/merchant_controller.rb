class Admin::MerchantController < ApplicationController
  before_action :require_admin

  def show
    # binding.pry
    @merchant = Merchant.find(params[:id])
  end

  def index
    @merchants = Merchant.all

  end

  def update

    merchant = Merchant.find(params[:id])
    merchant.status = "disabled"
    merchant.items.each do |item|

      item[:active?] = false

      updated_item = item.update(deactivate_item)

    end
    merchant.update(disable_merchant)
    merchant.save
    flash[:notice] = "You have disable merchant #{merchant.id}"
    redirect_to "/admin/merchants"
  end

  private

    def deactivate_item
      params.permit(:active?)
    end

    def disable_merchant
      params.permit(:status)
    end

    def require_admin
      render file: "/public/404" unless current_admin?
    end
end
