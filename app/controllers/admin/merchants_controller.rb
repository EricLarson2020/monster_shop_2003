class Admin::MerchantsController < ApplicationController
  before_action :require_admin

  def show
    @merchant = Merchant.find(params[:id])
  end

  def index
    @merchants = Merchant.all

  end

  def update

    merchant = Merchant.find(params[:id])
    if merchant.status == "enabled"
      disables_merchant(merchant)
      flash[:notice] = "You have disable merchant #{merchant.id}"
    else
      enables_merchant(merchant)
      flash[:notice] = "You have enabled merchant #{merchant.id}"
  end
redirect_to "/admin/merchants"
end
  private

    def disables_merchant(merchant)
      merchant.status = "disabled"
      merchant.items.each do |item|
        item[:active?] = false
        updated_item = item.update(deactivate_item)
      end
      merchant.update(disable_merchant)
      merchant.save
    end

    def enables_merchant(merchant)
      merchant.status = "enabled"
      merchant.items.each do |item|
        item[:active?] = true
        updated_item = item.update(deactivate_item)
      end
      merchant.update(disable_merchant)
      merchant.save
    end

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
