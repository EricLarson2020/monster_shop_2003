require "rails_helper"

RSpec.describe "Profile Index Page", type: :feature do
  # it "Can get to profile page if logged in" do
  # jack = User.create!({
  #   name: "Jack",
  #   address: "333 Jack Blvd",
  #   city: "Denver",
  #   state: "Colorado",
  #   zip: 83243,
  #   email: "jjjjj",
  #   password: "3455",
  #   password_confirmation: "3455",
  #   role: 2
  #   })
  #
  #   visit "/login"
  #   fill_in :email, with: "jjjjj"
  #   fill_in :password, with: "3455"
  #   click_on "Submit"
  #   visit "/"
  #   within ".topnav" do
  #     click_link("Profile Page")
  #   end
  #   expect(current_path).to eql("/profile")
  # end
  #
  #   it "does not see profile page link when not logged in" do
  #     visit "/"
  #     within ".topnav" do
  #       expect(page).not_to have_css("Profile Page")
  #     end
  #   end
  #   it "can show the orders for a registered user" do
  #   jack = User.create!({
  #     name: "Jack",
  #     address: "333 Jack Blvd",
  #     city: "Denver",
  #     state: "Colorado",
  #     zip: 83243,
  #     email: "puppy@hotmail.com",
  #     password: "3455",
  #     password_confirmation: "3455",
  #     role: 0
  #     })
  #
  #
  #
  #     visit "/login"
  #     fill_in :email, with: "puppy@hotmail.com"
  #     fill_in :password, with: "3455"
  #     click_on "Submit"
  #
  #     bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
  #     chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
  #     order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: jack.id)
  #     order_1.item_orders.create!(item: chain, price: chain.price, quantity: 2)
  #
  #     visit "/profile"
  #     click_link "My Orders"
  #     expect(current_path).to eql("/profile/orders")
  #
  # end

  it "does not have link if no orders are present" do
    jack = User.create!({
      name: "Jack",
      address: "333 Jack Blvd",
      city: "Denver",
      state: "Colorado",
      zip: 83243,
      email: "doggy@hotmail.com",
      password: "3455",
      password_confirmation: "3455",
      role: 0
      })



      visit "/login"
      fill_in :email, with: "doggy@hotmail.com"
      fill_in :password, with: "3455"
      click_on "Submit"
      visit "/profile"
      expect(page).not_to have_link("My Orders")

  end
end

#   User Story 27, User Profile displays Orders link
#
# As a registered user
# When I visit my Profile page
# And I have orders placed in the system
# Then I see a link on my profile page called "My Orders"
# When I click this link my URI path is "/profile/orders"
