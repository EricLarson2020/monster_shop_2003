require "rails_helper"

RSpec.describe "Register Index Page", type: :feature do
  it "Can log out and empty cart contents" do
  jil = User.create!({
  name: "Jack",
  address: "333 Jack Blvd",
  city: "Denver",
  state: "Colorado",
  zip: 83243,
  email: "vvvv@hotmail.com",
  password: "3455",
  password_confirmation: "3455",
  role: 2
  })

  @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
  @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

  @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
  @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
  @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
  visit "/login"
  fill_in :email, with: "vvvv@hotmail.com"
  fill_in :password, with: "3455"
  click_on "Submit"

  visit "/items/#{@paper.id}"
  click_on "Add To Cart"
  visit "/items/#{@tire.id}"
  click_on "Add To Cart"
  visit "/items/#{@pencil.id}"
  click_on "Add To Cart"
  @items_in_cart = [@paper,@tire,@pencil]
  visit "/cart"
  expect(page).to have_css("#cart-item-#{@tire.id}")
  expect(page).to have_css("#cart-item-#{@pencil.id}")
  expect(page).to have_css("#cart-item-#{@paper.id}")

  visit "/logout"
  expect(current_path).to eql("/")
  expect(page).to have_content("You have logged out")

  visit "/cart"
  expect(page).to_not have_css("#cart-item-#{@tire.id}")
  expect(page).to_not have_css("#cart-item-#{@pencil.id}")
  expect(page).to_not have_css("#cart-item-#{@paper.id}")
  end
end
