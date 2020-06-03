require 'rails_helper'

RSpec.describe 'merchant show page', type: :feature do
  describe 'As a user' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @dog_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @merchant = User.create({name: "Bob", address: "333 Bob Blvd", city: "Denver", state: "Colorado", zip: 32333, email: "merchant@email.com", password: "1234", role:1, merchant_id: @dog_shop.id})
      @user = User.create({name: "Bob", address: "333 Bob Blvd", city: "Denver", state: "Colorado", zip: 32333, email: "user@email.com", password: "1234", role:0})

    end

    it 'I can see a merchants name, address, city, state, zip' do
      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_content("Brian's Bike Shop")
      expect(page).to have_content("123 Bike Rd.\nRichmond, VA 23137")
    end

    it 'I can see a link to visit the merchant items' do
      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_link("All #{@bike_shop.name} Items")

      click_on "All #{@bike_shop.name} Items"

      expect(current_path).to eq("/merchants/#{@bike_shop.id}/items")
    end

    it "only merchant can see link to merchant dashboard in nav bar" do
      visit "/login"

      fill_in :email, with: @merchant.email
      fill_in :password, with: @merchant.password
      click_on "Submit"

      visit "/"
      within '.topnav' do
        expect(page).to have_content("Dashboard")
      end

      visit "/merchants"
      within '.topnav' do
        expect(page).to have_content("Dashboard")
      end

      visit "logout"
      visit "login"

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_on "Submit"

      visit "/"
      within '.topnav' do
        expect(page).to_not have_content("Dashboard")
      end

      visit "/merchants"
      within '.topnav' do
        expect(page).to_not have_content("Dashboard")
      end
    end

    it "Merchant can use dashboard link to navigate to dashboard" do
      visit "/login"

      fill_in :email, with: @merchant.email
      fill_in :password, with: @merchant.password
      click_on "Submit"
      visit "/"

      within '.topnav' do
        click_on "Dashboard"
      end

      expect(current_path).to eq("/merchant/dashboard")
    end

    it "Dashboard link does not show up while in dashboard" do
      visit "/login"

      fill_in :email, with: @merchant.email
      fill_in :password, with: @merchant.password
      click_on "Submit"

      within '.topnav' do
        expect(page).to_not have_content("Dashboard")
      end

      expect(current_path).to eq("/merchant/dashboard")
    end

  end
end
