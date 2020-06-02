class OrdersController <ApplicationController

  def new

  end

  def show
    @order = Order.find(params[:id])

  end

  def create


    order = current_user.orders.create(order_params)
    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      flash[:notice] = "Your order was created"
      end
      session.delete(:cart)
      redirect_to "/profile/orders"
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end

  def destroy
    order = Order.find(params[:id])
    order_of_id = (params[:id])
    order.status = "cancelled"
    item_orders = ItemOrder.where(order_id: order_of_id)

    item_orders.each do |item|

      if item.status == "fulfilled"
        found_item = Item.find(item.item_id)
        found_item.inventory += item.quantity




      item.status = "unfulfilled"
      found_item.update(update_item_inventory)
      found_item.save

      item.update(update_item_order_status)
      item.save
      end
    end

    order.update(order_update_status)
    order.save
    flash[:notice] = "Your order has been cancelled"
    redirect_to "/profile"

  end




  private

  def update_item_inventory
    params.permit(:inventory)
  end


  def update_item_order_status
    params.permit(:status)
  end

  def order_update_status
    params.permit(:name, :address, :city, :state, :zip, :status)
  end

  def order_params
    defaults = {status: 'pending'}
    params.permit(:name, :address, :city, :state, :zip).reverse_merge(defaults)
  end
end
