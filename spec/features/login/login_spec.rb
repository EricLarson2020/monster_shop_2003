require "rails_helper"

RSpec.describe "Register Index Page", type: :feature do
  # it "basic user can log in" do
  #   visit "/login"
  #
  #  jack = User.create!({
  #     name: "Jack",
  #     address: "333 Jack Blvd",
  #     city: "Denver",
  #     state: "Colorado",
  #     zip: 83243,
  #     email: "jack@hotmail.com",
  #     password: "3455",
  #     password_confirmation: "3455",
  #     role: 0
  #     })
  #
  #   fill_in :email, with: "jack@hotmail.com"
  #   fill_in :password, with: "3455"
  #   click_on "Submit"
  #   expect(current_path).to eq("/profile")
  #   expect(page).to have_content("You are logged in as Jack")
  # end
  #
  # it "merchant user can login" do
  #   jack = User.create!({
  #     name: "Jack",
  #     address: "333 Jack Blvd",
  #     city: "Denver",
  #     state: "Colorado",
  #     zip: 83243,
  #     email: "john@hotmail.com",
  #     password: "3455",
  #     password_confirmation: "3455",
  #     role: 1
  #     })
  #
  #     visit "/login"
  #     fill_in :email, with: "john@hotmail.com"
  #     fill_in :password, with: "3455"
  #     click_on "Submit"
  #     expect(current_path).to eq("/merchant/dashboard")
  #     expect(page).to have_content("You are logged in as Jack")
  #
  # end
  #
  # it "admin user can login" do
  #   jack = User.create!({
  #     name: "Jack",
  #     address: "333 Jack Blvd",
  #     city: "Denver",
  #     state: "Colorado",
  #     zip: 83243,
  #     email: "jake@hotmail.com",
  #     password: "3455",
  #     password_confirmation: "3455",
  #     role: 2
  #     })
  #
  #     visit "/login"
  #     fill_in :email, with: "jake@hotmail.com"
  #     fill_in :password, with: "3455"
  #     click_on "Submit"
  #     expect(current_path).to eq("/admin/dashboard")
  #     expect(page).to have_content("You are logged in as Jack")
  # end
  #
  # it "can not log in with invalid email" do
  #   jil = User.create!({
  #     name: "Jack",
  #     address: "333 Jack Blvd",
  #     city: "Denver",
  #     state: "Colorado",
  #     zip: 83243,
  #     email: "jil@hotmail.com",
  #     password: "3455",
  #     password_confirmation: "3455",
  #     role: 2
  #     })
  #
  #   visit "/login"
  #   fill_in :email, with: "bob@hotmail.com"
  #   fill_in :password, with: "3455"
  #   click_on "Submit"
  #   expect(current_path).to eql("/login")
  #   expect(page).to have_content("Sorry, your credentials are bad.")
  # end
  #
  # it "can not log in with invalid email" do
  #   jil = User.create!({
  #     name: "Jack",
  #     address: "333 Jack Blvd",
  #     city: "Denver",
  #     state: "Colorado",
  #     zip: 83243,
  #     email: "jane@hotmail.com",
  #     password: "3455",
  #     password_confirmation: "3455",
  #     role: 2
  #     })
  #
  #   visit "/login"
  #   fill_in :email, with: "jane@hotmail.com"
  #   fill_in :password, with: "2222"
  #   click_on "Submit"
  #   expect(current_path).to eql("/login")
  #   expect(page).to have_content("Sorry, your credentials are bad.")
  # end
  #
  # it "redirects default user that are already logged in" do
  #   jil = User.create!({
  #     name: "Jack",
  #     address: "333 Jack Blvd",
  #     city: "Denver",
  #     state: "Colorado",
  #     zip: 83243,
  #     email: "jane@hotmail.com",
  #     password: "3455",
  #     password_confirmation: "3455",
  #     role: 0
  #     })
  #
  #   visit "/login"
  #   fill_in :email, with: "jane@hotmail.com"
  #   fill_in :password, with: "3455"
  #   click_on "Submit"
  #   expect(current_path).to eql("/profile")
  #   visit "/login"
  #   expect(current_path).to eql("/profile")
  #   expect(page).to have_content("You are already logged in")
  # end
  #
  # it "redirects merchant users that are already logged in" do
  #
  #   jil = User.create!({
  #     name: "Jack",
  #     address: "333 Jack Blvd",
  #     city: "Denver",
  #     state: "Colorado",
  #     zip: 83243,
  #     email: "adsc@hotmail.com",
  #     password: "3455",
  #     password_confirmation: "3455",
  #     role: 1
  #     })
  #     visit "/login"
  #     fill_in :email, with: "adsc@hotmail.com"
  #     fill_in :password, with: "3455"
  #     click_on "Submit"
  #     expect(current_path).to eql("/merchant/dashboard")
  #     visit "/login"
  #     expect(current_path).to eql("/merchant/dashboard")
  #     expect(page).to have_content("You are already logged in")
  #   end
  #
  # it "redirects admin users that are already logged in" do
  #   jil = User.create!({
  #   name: "Jack",
  #   address: "333 Jack Blvd",
  #   city: "Denver",
  #   state: "Colorado",
  #   zip: 83243,
  #   email: "ssss@hotmail.com",
  #   password: "3455",
  #   password_confirmation: "3455",
  #   role: 2
  #   })
  #   visit "/login"
  #   fill_in :email, with: "ssss@hotmail.com"
  #   fill_in :password, with: "3455"
  #   click_on "Submit"
  #   expect(current_path).to eql("/admin/dashboard")
  #   visit "/login"
  #   expect(current_path).to eql("/admin/dashboard")
  #   expect(page).to have_content("You are already logged in")
  # end

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
# As a registered user, merchant, or admin
# When I visit the logout path
# I am redirected to the welcome / home page of the site
# And I see a flash message that indicates I am logged out
# Any items I had in my shopping cart are deleted
