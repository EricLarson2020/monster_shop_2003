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
  validates_numericality_of :inventory, greater_than: 0

  after_initialize :set_default_image


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

  def set_default_image
    self.image = "https://cdn.dribbble.com/users/120891/screenshots/4649285/dribble_42.png" if self.image == ""
  end

  def find_quantity
    item_orders.joins(:item).pluck(:quantity).first
  end

  def check_status
    item_orders.joins(:item).pluck(:status).first
  end




  # def self.top_five
  #   # items = Item.left_outer_joins(:order)
  #   binding.pry
  # end
end
