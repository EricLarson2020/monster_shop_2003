require 'rails_helper'

describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it {should belong_to :user}
    it {should have_many :item_orders}
    it {should have_many(:items).through(:item_orders)}
  end


  describe 'instance methods' do
    before :each do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      jack = User.create ({name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "999@hotmail.com", password: "3455"})
      @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: jack.id, status: "pending")
      @order_2 = Order.create!(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80204, user_id: jack.id, created_at: '2010-12-01 00:00:01', updated_at: '2011-12-01 00:00:01')
      @order_3 = Order.create!(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80204, user_id: jack.id, status: "pending")
      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2, status: "fulfilled")
      @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3, status: "fulfilled")
      @order_2.item_orders.create!(item: @tire, price: @tire.price, quantity: 4, status: "fulfilled")
      @order_3.item_orders.create!(item: @tire, price: @tire.price, quantity: 4, status: "unfulfilled")

    end
    it 'grandtotal' do
      expect(@order_1.grandtotal).to eq(230)
    end

    it 'total_quantity' do
      expect(@order_1.total_quantity).to eql(5)
    end

    it 'find_order_status' do
      expect(@order_1.find_order_status(@order_1.id)).to eq("packaged")
    end

    it 'find_order_status' do
      expect(@order_3.find_order_status(@order_3.id)).to eq("pending")
    end

    it 'packaged_orders' do
      meg = User.create!({name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "9@hotmail.com", password: "3455"})
      order_1 = Order.create!(name: 'Meg', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80204, user_id: meg.id, status: "pending")
      order_2 = Order.create!(name: 'Meg', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80204, user_id: meg.id, status: "packaged")
      order_3 = Order.create!(name: 'Meg', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80204, user_id: meg.id, status: "shipped")
      order_4 = Order.create!(name: 'Meg', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80204, user_id: meg.id, status: "cancelled")

      expect(Order.pending_orders).to eq([@order_1, @order_3, order_1,])
      expect(Order.packaged_orders).to eq([order_2])
      expect(Order.shipped_orders).to eq([order_3])
      expect(Order.cancelled_orders).to eq([order_4])
    end
  end
end
