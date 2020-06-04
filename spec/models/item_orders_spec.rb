require 'rails_helper'

describe ItemOrder, type: :model do
  describe "validations" do
    it { should validate_presence_of :order_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :price }
    it { should validate_presence_of :quantity }
  end

  describe "relationships" do
    it {should belong_to :item}
    it {should belong_to :order}
  end



  describe 'instance methods' do
    it 'subtotal' do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      jack = User.create ({name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "777@hotmail.com", password: "3455"})
      order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: jack.id)
      item_order_1 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)
      expect(item_order_1.subtotal).to eq(200)
    end
  end


  describe 'class methods' do
    it "top_five" do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      helmet = meg.items.create(name: "Helmet", description: "Keeps you safe", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 13)
      toy = meg.items.create(name: "Helmet", description: "Keeps you safe", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 13)
      racket = meg.items.create(name: "Helmet", description: "Keeps you safe", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 13)
      ball = meg.items.create(name: "Helmet", description: "Keeps you safe", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 13)
      jack = User.create ({name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "777@hotmail.com", password: "3455"})
      order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: jack.id)
      item_order_1 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 7)
      item_order_2 = order_1.item_orders.create!(item: helmet, price: helmet.price, quantity: 6)
      item_order_3 = order_1.item_orders.create!(item: toy, price: toy.price, quantity: 5)
      item_order_4 = order_1.item_orders.create!(item: racket, price: racket.price, quantity: 4)
      item_order_5 = order_1.item_orders.create!(item: ball, price: ball.price, quantity: 3)

      expect(ItemOrder.top_five.first.id).to eq(tire.id)
      expect(ItemOrder.top_five.last.id).to eq(ball.id)
    end
    it "bottom_five" do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      helmet = meg.items.create(name: "Helmet", description: "Keeps you safe", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 13)
      toy = meg.items.create(name: "Helmet", description: "Keeps you safe", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 13)
      racket = meg.items.create(name: "Helmet", description: "Keeps you safe", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 13)
      ball = meg.items.create(name: "Helmet", description: "Keeps you safe", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 13)
      jack = User.create ({name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "777@hotmail.com", password: "3455"})
      order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: jack.id)
      item_order_1 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 7)
      item_order_2 = order_1.item_orders.create!(item: helmet, price: helmet.price, quantity: 6)
      item_order_3 = order_1.item_orders.create!(item: toy, price: toy.price, quantity: 5)
      item_order_4 = order_1.item_orders.create!(item: racket, price: racket.price, quantity: 4)
      item_order_5 = order_1.item_orders.create!(item: ball, price: ball.price, quantity: 3)

      expect(ItemOrder.bottom_five.first.id).to eq(ball.id)
      expect(ItemOrder.bottom_five.last.id).to eq(tire.id)
    end
  end

end
