require "rails_helper"

RSpec.describe "Profile Orders Page", type: :feature do
  it "Can display information for all the orders" do
    mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

    jack = User.create ({name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "777@hotmail.com", password: "3455"})
    visit "/login"
    fill_in :email, with: "777@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"

    order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: jack.id, created_at: '2010-12-01 00:00:01', updated_at: '2011-12-01 00:00:01')
    order_2 = Order.create!(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80204, user_id: jack.id, created_at: '2010-12-01 00:00:01', updated_at: '2011-12-01 00:00:01')
    order_3 = Order.create!(name: 'Mike', address: '123 Dao St', city: 'Denver', state: 'CO', zip: 80210, user_id: jack.id, created_at: '2010-12-01 00:00:01', updated_at: '2011-12-01 00:00:01')

    order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)
    order_1.item_orders.create!(item: pencil, price: pencil.price, quantity: 3)
    order_2.item_orders.create!(item: pencil, price: pencil.price, quantity: 2)
    order_2.item_orders.create!(item: tire, price: tire.price, quantity: 2, status: "unfulfilled")
    order_2.item_orders.create!(item: paper, price: paper.price, quantity: 2)
    order_3.item_orders.create!(item: pencil, price: pencil.price, quantity: 5)

    visit "/profile/orders"

    within ".order-#{order_1.id}" do
      expect(page).to have_content(order_1.id)
      expect(page).to have_content(order_1.created_at)
      expect(page).to have_content(order_1.updated_at)
      expect(page).to have_content(order_1.status)
      expect(page).to have_content(5)
      expect(page).to have_content("$206")
    end

    within ".order-#{order_2.id}" do
      expect(page).to have_content(order_2.id)
      expect(page).to have_content(order_2.created_at)
      expect(page).to have_content(order_2.updated_at)
      expect(page).to have_content(order_2.status)
      expect(page).to have_content(6)
      expect(page).to have_content("$244")
    end

    within ".order-#{order_3.id}" do
      expect(page).to have_content(order_3.id)
      expect(page).to have_content(order_3.created_at)
      expect(page).to have_content(order_3.updated_at)
      expect(page).to have_content(order_3.status)
      expect(page).to have_content(5)
      expect(page).to have_content("$10")
    end

  end
end

# As a registered user
# When I visit my Profile Orders page, "/profile/orders"
# I see every order I've made, which includes the following information:
# - the ID of the order, which is a link to the order show page
# - the date the order was made
# - the date the order was last updated
# - the current status of the order
# - the total quantity of items in the order
# - the grand total of all items for that order
