class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :item_orders
  has_many :items, through: :item_orders
  belongs_to :user

  def total_quantity
    answer = ItemOrder.where(order_id: id).pluck(:quantity)
    answer.sum
  end

  def grandtotal
    item_orders.sum('price * quantity')
  end

  # def self.order_by_status
  # need for user story 32
  #   # binding.pry
  #   joins(:orders).select('orders.*')
  # end


  def find_order_status(id)
    orders = Order.find(id)
    item_orders = ItemOrder.where(order_id: id)
    if item_orders.any? {|order| order.status == "unfulfilled"}
        "pending"
      # orders.save
    else
      "packaged"
    end
  end

  def self.packaged_orders
    where(status: "packaged")
  end

  def self.pending_orders
    where(status: "pending")
  end

  def self.shipped_orders
    where(status: "shipped")
  end

  def self.cancelled_orders
    where(status: "cancelled")
  end


end
