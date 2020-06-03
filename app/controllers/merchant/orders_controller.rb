class Merchant::OrdersController < ApplicationController

  def show

    @merchant = current_user.merchant
    @order = Order.find(params[:order_id])
    @items = @order.items.where(merchant_id: @merchant.id)
    
  end

end
