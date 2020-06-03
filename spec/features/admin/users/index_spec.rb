require 'rails_helper'

RSpec.describe "Admin Users Index Page" do
  describe "as an admin, when I visit the users index page" do
    it "can see all users in the system with their info" do
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

      visit "/admin/users"

      within(".user-#{user.id}") do
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.created_at)
        expect(page).to have_content(user.role.capitalize)
        expect(page).to have_link("Jill")
        expect(page).to have_no_content(user1.name)
      end

      within(".user-#{user1.id}") do
        expect(page).to have_content(user1.name)
        expect(page).to have_content(user1.created_at)
        expect(page).to have_content(user1.role.capitalize)
        expect(page).to have_link("Sarah")
        expect(page).to have_no_content(user2.name)
      end
    end
  end
end

# User Story 53, Admin User Index Page

# As an admin user
# When I click the "Users" link in the nav (only visible to admins)
# Then my current URI route is "/admin/users"
# Only admin users can reach this path.
# I see all users in the system
# Each user's name is a link to a show page for that user ("/admin/users/5")
# Next to each user's name is the date they registered
# Next to each user's name I see what type of user they are