class  Merchant::ItemsController < ApplicationController 
  def index
    @items = current_user.merchant.items
  end

  def update
    item = Item.find(params[:item_id])
    if item.active? == true
      item.update(active?: false)
      redirect_to "/merchant/items"
      flash[:notice] = "#{item.name} is no longer for sale."
    elsif item.active? == false
      item.update(active?: true)
      redirect_to "/merchant/items"
      flash[:notice] = "#{item.name} is now for sale."
    end
  end

  def destroy
    item = Item.find(params[:item_id])
    flash[:success] = "#{item.name} has been deleted." if item.destroy
    redirect_to "/merchant/items"
  end
end