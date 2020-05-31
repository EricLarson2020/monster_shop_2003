class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]
  validates_numericality_of :price, greater_than: 0

  def self.total_quantity
    count
  end

  def average_review
    reviews.average(:rating)
  end

  def sorted_reviews(limit, order)
    reviews.order(rating: order).limit(limit)
  end

  def no_orders?
    item_orders.empty?
  end

  def quantity
    item_orders.joins(:order).pluck(:quantity).first
  end

  def subtotal
    quantity * price
  end
  # def self.top_five
  #   # items = Item.left_outer_joins(:order)
  #   binding.pry
  # end
end
