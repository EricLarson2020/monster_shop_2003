class Merchant::OrdersController < ApplicationController

  def show

    @merchant = current_user.merchant
    @order = Order.find(params[:order_id])
    @items = @order.items.where(merchant_id: @merchant.id)

  end

  def update
    @order = Order.find(params[:order_id])
    item_inventory_update
    flash[:notice] = "You have fulfilled an item request"
    redirect_to "/merchant/orders/#{@order.id}"
  end

  private

  def item_params
      params.permit(:name, :description, :price, :inventory, :image)
  end

  def item_order_params
    params.permit(:status)
  end

  def item_inventory_update
    item = Item.find(params[:item_id])
    order= Order.find(params[:order_id])
    item_order = ItemOrder.where(item_id: item.id, order_id: order.id).first
    new_inventory = item.inventory - item_order.quantity
    item_order.update(status: "fulfilled")
    item.update(inventory: new_inventory)
  end


end
