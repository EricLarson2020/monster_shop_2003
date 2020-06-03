
require 'rails_helper'

RSpec.describe 'Site Navigation' do
  before :each do
    @dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    @merchant = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "john@hotmail.com", password: "3455", password_confirmation: "3455", role: 1, merchant_id: @dog_shop.id})
    @user = User.create!(name:"Jill", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email2@email.com", password: "abcd", password_confirmation:"abcd", role:0)
    @admin = User.create!(name:"Jan", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email@email.com", password: "abcd", password_confirmation:"abcd", role:2)
  end

  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/merchants'

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq('/merchants')
    end

    it "I can see a cart indicator on all pages" do
      visit '/merchants'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

      visit '/items'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end
    end

    it "visitors see 404 error when trying to access /merchants, /admin and /profile" do
      error_404 = "The page you were looking for doesn't exist (404)"
      visit "/admin"
      expect(page).to have_content(error_404)
      visit "/merchant"
      expect(page).to have_content(error_404)
      visit "/profile"
      expect(page).to have_content(error_404)
    end

    it "User does not have access to /admin and /merchant" do
      error_404 = "The page you were looking for doesn't exist (404)"

      visit "login"
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_on "Submit"

      visit "/admin"
      expect(page).to have_content(error_404)
      visit "/merchant"
      expect(page).to have_content(error_404)
    end

    it "Merchant does not have access to /admin" do
      error_404 = "The page you were looking for doesn't exist (404)"
      visit "login"
      fill_in :email, with: @merchant.email
      fill_in :password, with: @merchant.password
      click_on "Submit"

      visit "/admin"
      expect(page).to have_content(error_404)
    end

    it "Admin does not have acces to /merchant and /cart" do
      error_404 = "The page you were looking for doesn't exist (404)"
      visit "login"
      fill_in :email, with: @admin.email
      fill_in :password, with: @admin.password
      click_on "Submit"

      visit "/merchant"
      expect(page).to have_content(error_404)
      visit "/cart"
      expect(page).to have_content(error_404)
    end
  end
end
