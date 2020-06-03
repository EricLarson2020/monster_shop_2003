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


  private

  def item_params
    params.permit(:name, :description, :price, :inventory, :image)
  end
end
