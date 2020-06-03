require 'rails_helper'

RSpec.describe "Admin Merchants Index Page" do
  describe "as an admin, when I visit the merchants index page" do
    it "can see all merchants in the system with their info" do
      dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      admin = User.create!(name:"Jan", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email@email.com", password: "abcd", password_confirmation:"abcd", role:2)
      employee = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "john@hotmail.com", password: "3455", password_confirmation: "3455", role: 1, merchant_id: dog_shop.id})
      user = User.create!(name:"Jill", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email2@email.com", password: "abcd", password_confirmation:"abcd", role:0)
      user1 = User.create!(name:"Sarah", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email1@email.com", password: "abcd", password_confirmation:"abcd", role:0)
      user2 = User.create!(name:"Kevin", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email3@email.com", password: "abcd", password_confirmation:"abcd", role:0)
  
      visit "/login"
      fill_in :email, with: "email@email.com"
      fill_in :password, with: "abcd"
      click_on "Submit"

      visit "/admin/merchants"

      within(".merchant-#{dog_shop.id}") do
        expect(page).to have_content(dog_shop.name)
        expect(page).to have_content(dog_shop.city)
        expect(page).to have_content(dog_shop.state)
        expect(page).to have_link("Dog Shop")
      end
    end
  end
end

# User Story 52, Admin Merchant Index Page

# As an admin user
# When I visit the merchant's index page at "/admin/merchants"
# I see all merchants in the system
# Next to each merchant's name I see their city and state
# The merchant's name is a link to their Merchant Dashboard at routes such as "/admin/merchants/5"
# I see a "disable" button next to any merchants who are not yet disabled
# I see an "enable" button next to any merchants whose accounts are disabled