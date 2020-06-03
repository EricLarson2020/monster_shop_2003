require 'rails_helper'

RSpec.describe "Admin Users Index Page" do
  describe "as an admin, when I visit the users index page" do
    it "can see all users in the system with their info" do
      dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      admin = User.create!(name:"Jan", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email@email.com", password: "abcd", password_confirmation:"abcd", role:2)
      user = User.create!(name:"Jill", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email2@email.com", password: "abcd", password_confirmation:"abcd", role:0)
      user1 = User.create!(name:"Sarah", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email1@email.com", password: "abcd", password_confirmation:"abcd", role:0)
  
      visit "/login"
      fill_in :email, with: "email@email.com"
      fill_in :password, with: "abcd"
      click_on "Submit"

      visit "/admin/users"

      within(".user-#{user.id}") do
        click_link "Jill"
      end

      expect(current_path).to eq("/admin/users/#{user.id}")
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.address)
      expect(page).to have_content(user.city)
      expect(page).to have_content(user.state)
      expect(page).to have_content(user.zip)
      expect(page).to have_content(user.email)
      expect(page).to have_no_content("Edit")
    end
  end
end

# User Story 54, Admin User Profile Page

# As an admin user
# When I visit a user's profile page ("/admin/users/5")
# I see the same information the user would see themselves
# I do not see a link to edit their profile