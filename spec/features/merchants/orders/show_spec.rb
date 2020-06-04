require "rails_helper"

RSpec.describe "As a merchant employee, when I visit my orders show page" do
  it "I can see the name and adress of the order and my item info" do
    other_merchant = Merchant.create!(name: "Other Dog Shop", address: 'Other St.', city: 'Denver', state: 'CO', zip: 80210)
    dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    merchant = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "sales@hotmail.com", password: "3455", password_confirmation: "3455", role: 1, merchant_id: dog_shop.id})
    pull_toy = dog_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    tennis_ball = dog_shop.items.create!(name: "Tennis Ball", description: "Great ball!", price: 5, image: "http://lovencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 40)
    racket = dog_shop.items.create!(name: "Tennis Racket", description: "Great Tennis Racket!", price: 200, image: "http://lvencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 10)
    other_racket = other_merchant.items.create!(name: "Other Racket", description: "OK Tennis Racket!", price: 200, image: "http://lvencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 10)
    order1 = Order.create!(name: "jack", address: "1234 something", city: "Den", state: "CO", zip: 12344, user: merchant)
    itemorder_1 = order1.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 2)
    itemorder_2 = order1.item_orders.create!(item: tennis_ball, price: tennis_ball.price, quantity: 1)
    itemorder_3 = order1.item_orders.create!(item: racket, price: racket.price, quantity: 1)
    itemorder_4 = order1.item_orders.create!(item: other_racket, price: other_racket.price, quantity: 1)
    visit "/login"
    fill_in :email, with: "sales@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"

    visit '/merchant'
    within ".order-#{order1.id}", match: :first do
      click_link "#{order1.id}"
    end
    expect(current_path).to eql("/merchant/orders/#{order1.id}")
    expect(page).to have_content(order1.name)
    expect(page).to have_content(order1.address)
    within(".item-#{pull_toy.id}") do
      expect(page).to have_content(pull_toy.name)
      expect(page).to have_content(pull_toy.image)
      expect(page).to have_content(pull_toy.price)
      expect(page).to have_content(itemorder_1.quantity)
    end
    expect(page).to have_css(".item-#{tennis_ball.id}")
    within ".item-#{tennis_ball.id}" do
      expect(page).to have_content(tennis_ball.name)
      expect(page).to have_content(tennis_ball.image)
      expect(page).to have_content(tennis_ball.price)
      expect(page).to have_content(itemorder_2.quantity)
    end

    expect(page).not_to have_css(".item-#{other_racket.id}")

    within ".item-#{racket.id}" do
      expect(page).to have_content(racket.name)
      expect(page).to have_content(racket.image)
      expect(page).to have_content(racket.price)
      expect(page).to have_content(itemorder_3.quantity)
      click_link(racket.name)
    end
    expect(current_path).to eql("/items/#{racket.id}")

  end

  it "a merchant user can fulfull orders if they have the inventory" do

    dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    merchant = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "moresales@hotmail.com", password: "3455", password_confirmation: "3455", role: 1, merchant_id: dog_shop.id})
    pull_toy = dog_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    tennis_ball = dog_shop.items.create!(name: "Tennis Ball", description: "Great ball!", price: 5, image: "http://lovencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 40)
    racket = dog_shop.items.create!(name: "Tennis Racket", description: "Great Tennis Racket!", price: 200, image: "http://lvencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 10)
    order1 = Order.create!(name: "jack", address: "1234 something", city: "Den", state: "CO", zip: 12344, user: merchant)
    itemorder_1 = order1.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 2)
    itemorder_2 = order1.item_orders.create!(item: tennis_ball, price: tennis_ball.price, quantity: 1)
    itemorder_3 = order1.item_orders.create!(item: racket, price: racket.price, quantity: 1)
    visit "/login"
    fill_in :email, with: "moresales@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"
    visit  "/merchant/orders/#{order1.id}"
    within "item-#{pull_toy.id}" do
      click_link "Fulfill"
    end
    expect(current_path).to eql("/merchant/orders/#{order1.id}")
    expect(page).to have_text("You have fulfilled an item request")

  end
end
# User Story 50, Merchant fulfills part of an order
#
# As a merchant employee
# When I visit an order show page from my dashboard
# For each item of mine in the order
# If the user's desired quantity is equal to or less than my current inventory quantity for that item
# And I have not already "fulfilled" that item:
# - Then I see a button or link to "fulfill" that item
# - When I click on that link or button I am returned to the order show page
# - I see the item is now fulfilled
# - I also see a flash message indicating that I have fulfilled that item
# - the item's inventory quantity is permanently reduced by the user's desired quantity
#
# If I have already fulfilled this item, I see text indicating such.
