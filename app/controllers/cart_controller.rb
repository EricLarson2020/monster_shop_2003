class CartController < ApplicationController
  def add_item
    item = Item.find(params[:item_id])
    cart.add_item(item.id.to_s)
    flash[:success] = "#{item.name} was successfully added to your cart"
    redirect_to "/items"
  end

  def add_quantity
      item = Item.find(params[:item_id])
      quantity = params[:quantity].to_i
      inventory = item.inventory
      cart.add_quantity(quantity, item, inventory)
      redirect_to '/cart'
  end

  def decrease_quantity
    item = Item.find(params[:item_id])
    quantity = params[:quantity_decrease].to_i
    cart.remove_quantity(quantity, item)
    redirect_to '/cart'
  end

  def show
    @items = cart.items
  end

  def empty
    session.delete(:cart)
    redirect_to '/cart'
  end

  def remove_item
    session[:cart].delete(params[:item_id])
    redirect_to '/cart'
  end


end
