require "rails_helper"

RSpec.describe "Profile Orders Show Page", type: :feature do
  it "Can display info for a single order" do
    mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    jack = User.create ({name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "2323@hotmail.com", password: "3455"})
    visit "/login"
    fill_in :email, with: "2323@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"

      order = Order.create!(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80204, user_id: jack.id, created_at: '2010-12-01 00:00:01', updated_at: '2011-12-01 00:00:01', status: 'pending')
      order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: jack.id, created_at: '2010-12-01 00:00:01', updated_at: '2011-12-01 00:00:01', status: 'pending')
      order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)
      order_1.item_orders.create!(item: pencil, price: pencil.price, quantity: 3)
      order.item_orders.create!(item: pencil, price: pencil.price, quantity: 2)
      order.item_orders.create!(item: tire, price: tire.price, quantity: 2)
      order.item_orders.create!(item: paper, price: paper.price, quantity: 2)

      visit "/profile/orders"
      click_link "Show Order #{order.id}"
      expect(current_path).to eql("/profile/orders/#{order.id}")
      expect(page).to have_content(order.id)
      expect(page).to have_content(order.created_at)
      expect(page).to have_content(order.updated_at)
      expect(page).to have_content(order.status)
      within ".item-#{tire.id}" do
        expect(page).to have_content(tire.name)
        expect(page).to have_content(tire.description)
        expect(page).to have_content(tire.image)
        expect(page).to have_content("Item Quantity: 2")
        expect(page).to have_content(tire.price)
        expect(page).to have_content("$200")
      end

      within ".item-#{paper.id}" do
        expect(page).to have_content(paper.name)
        expect(page).to have_content(paper.description)
        expect(page).to have_content(paper.image)
        expect(page).to have_content("Item Quantity: 2")
        expect(page).to have_content(paper.price)
        expect(page).to have_content("$40")
      end

      within ".item-#{pencil.id}" do
        expect(page).to have_content(pencil.name)
        expect(page).to have_content(pencil.description)
        expect(page).to have_content(pencil.image)
        expect(page).to have_content("Item Quantity: 2")
        expect(page).to have_content(pencil.price)
        expect(page).to have_content("$4")
      end

      expect(page).not_to have_content(order_1.name)
      expect(page).to have_content("Total Quantity: 6")
      expect(page).to have_content("Grand Total: $244")

  end

  it "Can Cancel an order" do
    mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    jack = User.create ({name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "zzz3@hotmail.com", password: "3455"})
    visit "/login"
    fill_in :email, with: "zzz3@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"

      order = Order.create!(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80204, user_id: jack.id, created_at: '2010-12-01 00:00:01', updated_at: '2011-12-01 00:00:01', status: 'pending')
      order_item_1 = order.item_orders.create!(item: pencil, price: pencil.price, quantity: 2, status: "fulfilled")
      order_item_2 = order.item_orders.create!(item: tire, price: tire.price, quantity: 2)
      order_item_3 = order.item_orders.create!(item: paper, price: paper.price, quantity: 2, status: "fulfilled")
      visit "/items/#{pencil.id}"
      expect(page).to have_content("Inventory: 100")
      visit "/items/#{tire.id}"
      expect(page).to have_content("Inventory: 12")
      visit "/profile/orders/#{order.id}"
      click_link "Cancel Order"
      expect(current_path).to eql("/profile")
      expect(page).to have_content("Your order has been cancelled")



      visit "/items/#{pencil.id}"
      expect(page).to have_content("Inventory: 102")
      visit "/items/#{tire.id}"

      expect(page).to have_content("Inventory: 12")
      visit "/profile/orders/#{order.id}"
      expect(page).to have_content("Current Status: cancelled")

  end

  it "when all items in a cart have been fufilled status for all items is pending" do

    mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    jack = User.create ({name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "2323@hotmail.com", password: "3455"})
    visit "/login"
    fill_in :email, with: "2323@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"

    order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: jack.id, created_at: '2010-12-01 00:00:01', updated_at: '2011-12-01 00:00:01', status: "pending")
    order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2, status: "fulfilled")
    order_1.item_orders.create!(item: pencil, price: pencil.price, quantity: 3, status: "unfulfilled")

    visit "/profile/orders/#{order_1.id}"
    expect(page).to have_content("Current Status: pending")
  end

  it "when items are fulfilled status is packaged" do
    mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    jack = User.create ({name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "2323@hotmail.com", password: "3455"})
    visit "/login"
    fill_in :email, with: "2323@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"

    order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: jack.id, created_at: '2010-12-01 00:00:01', updated_at: '2011-12-01 00:00:01', status: "pending")
    order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2, status: "fulfilled")
    order_1.item_orders.create!(item: pencil, price: pencil.price, quantity: 3, status: "fulfilled")

    visit "/profile/orders/#{order_1.id}"
    expect(page).to have_content("Current Status: packaged")
  end



end
