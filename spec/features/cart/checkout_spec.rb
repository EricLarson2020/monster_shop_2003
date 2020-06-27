require 'rails_helper'

RSpec.describe 'Cart show' do
  describe 'When I have added items to my cart' do
    before(:each) do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      visit "/items/#{@paper.id}"
      click_on "Add To Cart"
      visit "/items/#{@tire.id}"
      click_on "Add To Cart"
      visit "/items/#{@pencil.id}"
      click_on "Add To Cart"
      @items_in_cart = [@paper,@tire,@pencil]

    end

    it 'Theres a link to checkout' do
      jack = User.create ({name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "777@hotmail.com", password: "3455"})
      visit "/login"
      fill_in :email, with: "777@hotmail.com"
      fill_in :password, with: "3455"
      click_on "Submit"
      visit "/cart"

      expect(page).to have_link("Checkout")

      click_on "Checkout"

      expect(current_path).to eq("/orders/new")
    end

    it "if user is a visitor, when they visit their cart they are asked to checkin" do

      visit "/cart"

      expect(page).to have_content("Please Register or Login to finish the checkout process")
      expect(page).to have_link("Register")
      expect(page).to have_link("Login")
      click_link "Register"
      expect(current_path).to eql("/users/register")
      visit "/cart"
      click_link "Login"
      expect(current_path).to eql("/login")
    end

    it "if registered user I do not see login message or links in cart page" do
      jil = User.create!({
      name: "Jack",
      address: "333 Jack Blvd",
      city: "Denver",
      state: "Colorado",
      zip: 83243,
      email: "nbmv@hotmail.com",
      password: "3455",
      password_confirmation: "3455",
      role: 0
      })
      visit "/login"
      fill_in :email, with: "nbmv@hotmail.com"
      fill_in :password, with: "3455"
      click_on "Submit"
      visit "/cart"
      expect(page).to_not have_content("Please register or login to finish the checkout process")
      expect(page).to_not have_link("Register")
      expect(page).to_not have_link("Login")
    end

  end

  describe 'When I havent added items to my cart' do
    it 'There is not a link to checkout' do
      visit "/cart"

      expect(page).to_not have_link("Checkout")
    end
  end



end
