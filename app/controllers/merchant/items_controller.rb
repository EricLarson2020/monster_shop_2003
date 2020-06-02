class  Merchant::ItemsController < ApplicationController
  def index
    @items = current_user.merchant.items
  end

  def new
    @item = Item.new
  end

  def create
    @merchant = current_user.merchant
    @item = @merchant.items.create(item_params)
    # binding.pry
    if @item.save
      flash[:notice] = "#{@item.name} has been saved."
      redirect_to "/merchant/items"
    else
      redirect_to "/merchant/items/new"
      flash[:notice] = @item.errors.full_messages.to_s
    end
  end

  def edit
    @item = Item.find(params[:item_id])
  end

  def update

    @item = Item.find(params[:item_id])

    params[:name] ? item_update(item_params) : status_update(@item)

  end

  def destroy
    item = Item.find(params[:item_id])
    flash[:success] = "#{item.name} has been deleted." if item.destroy
    redirect_to "/merchant/items"
  end

  private

  def item_params
    params.permit(:name, :description, :price, :inventory, :image)
  end

  def item_update(item_params)
    @item.update(item_params)
    if @item.save
      flash[:notice] = "Item has been updated."
      redirect_to "/merchant/items"
    else
      flash[:notice] = @item.errors.full_messages.to_s
      redirect_to "/merchant/items/#{@item.id}/edit"
    end
  end

  def status_update(item)

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
end
