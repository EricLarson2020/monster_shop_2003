class CartController < ApplicationController
  before_action :require_mercant_or_user


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
      if cart.remove_quantity(quantity, item) != false
        redirect_to '/cart'
      else
        session[:cart].delete(params[:item_id])
        redirect_to '/cart'
      end
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

  private
    def require_mercant_or_user
      if current_admin?
       render file: "/public/404"
      end
    end
end
