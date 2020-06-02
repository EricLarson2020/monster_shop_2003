class ProfileOrdersController < ApplicationController

  def index
    @user = current_user
  end

  def show
    @order = Order.find(params[:id])
    if @order.status == "cancelled" || @order.status == "shipped"
    else
  
        if @order.find_order_status(params[:id]) != @order.status
      @order.update(status: @order.find_order_status(params[:id]))
      end
    end
  end
end
