require 'rails_helper'

RSpec.describe "As a merchant employee, when I visit my items page" do
  it "I can delete an item if it has never been ordered" do
    dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    employee = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "john@hotmail.com", password: "3455", password_confirmation: "3455", role: 1, merchant_id: dog_shop.id})
    user = User.create!(name:"Jill", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email2@email.com", password: "abcd", password_confirmation:"abcd", role:0)

    pull_toy = dog_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    tennis_ball = dog_shop.items.create!(name: "Tennis Ball", description: "Great ball!", price: 5, image: "http://lovencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 40)
    racket = dog_shop.items.create!(name: "Tennis Racket", description: "Great Tennis Racket!", price: 200, image: "http://lvencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 10)

    order1 = Order.create!(name: "jack", address: "1234 something", city: "Den", state: "CO", zip: 12344, user: user)
    
    order1.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 2)
    order1.item_orders.create!(item: tennis_ball, price: tennis_ball.price, quantity: 1)

    visit "/login"
    fill_in :email, with: "john@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"
    visit '/merchant/items'

    within(".item-#{racket.id}") do
    expect(page).to have_link("Delete Item")
      click_link("Delete Item")
    end

    expect(current_path).to eq("/merchant/items")
    expect(page).to have_content("Tennis Racket has been deleted.")
  end
end

# User Story 44, Merchant deletes an item

# As a merchant employee
# When I visit my items page
# I see a button or link to delete the item next to each item that has never been ordered
# When I click on the "delete" button or link for an item
# I am returned to my items page
# I see a flash message indicating this item is now deleted
# I no longer see this item on the page