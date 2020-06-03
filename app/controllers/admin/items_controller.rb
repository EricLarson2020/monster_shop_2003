class Admin::ItemsController < Admin::BaseController


  def index

    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end


  def destroy
    item = Item.find(params[:item_id])
    flash[:success] = "#{item.name} has been deleted." if item.destroy
    redirect_to "/admin/merchants/#{params[:merchant_id]}/items"
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.create(item_params)
    if @item.save
      flash[:notice] = "#{@item.name} has been saved."
      redirect_to "/admin/merchants/#{@merchant.id}/items"
    else
      redirect_to "/admin/merchants/#{@merchant.id}/items/new"
      flash[:notice] = @item.errors.full_messages.to_s
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def update
      @item = Item.find(params[:item_id])

    params[:name] ? item_update(item_params) : status_update(@item)

  end


  private

  def item_params
    params.permit(:name, :description, :price, :inventory, :image)
  end

  def item_update(item_params)
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
    @item.update(item_params)
    if @item.save
      flash[:notice] = "Item has been updated."
      redirect_to "/admin/merchants/#{@merchant.id}/items"
    else
      flash[:notice] = @item.errors.full_messages.to_s
      redirect_to "/admin/merchants/#{@merchant.id}/items/#{@item.id}/edit"
    end
  end

  def status_update(item)
    @merchant = Merchant.find(params[:merchant_id])
    if item.active? == true
      item.update(active?: false)
      redirect_to "/admin/merchants/#{@merchant.id}/items"
      flash[:notice] = "#{item.name} is no longer for sale."
    elsif item.active? == false
      item.update(active?: true)
      redirect_to "/admin/merchants/#{@merchant.id}/items"
      flash[:notice] = "#{item.name} is now for sale."
    end
  end
end
