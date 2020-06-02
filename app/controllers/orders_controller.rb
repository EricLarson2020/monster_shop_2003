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

  def ship
    order = Order.find(params[:id])
    order.update!(status: "shipped")
    redirect_to "/admin/dashboard"
  end


  private

  def order_params
    defaults = {status: 'pending'}
    params.permit(:name, :address, :city, :state, :zip).reverse_merge(defaults)
  end
end
