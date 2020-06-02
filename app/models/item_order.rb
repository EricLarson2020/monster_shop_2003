class ItemOrder <ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity

  belongs_to :item
  belongs_to :order

  def subtotal
    price * quantity
  end

  def self.top_five
      joins(:item).select('items.id, (items.name) as name, sum(item_orders.quantity) as quantity').group('items.id').order('quantity DESC').limit(5)
  end

  def self.bottom_five
    joins(:item).select('items.id, (items.name) as name, sum(item_orders.quantity) as quantity').group('items.id').order('quantity ASC').limit(5)
  end



end
