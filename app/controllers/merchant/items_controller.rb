class  Merchant::ItemsController < ApplicationController 
  def index
    @items = current_user.merchant.items
  end

  def update
    item = Item.find(params[:item_id])
    item.update(active?: false)
    redirect_to "/merchant/items"
    flash[:notice] = "#{item.name} is no longer for sale."
  end
end