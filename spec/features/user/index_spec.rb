require 'rails_helper'

RSpec.describe "Register Index Page", type: :feature do
  it "Can register a user" do
    visit "/merchants"
    within "nav" do
      click_link "register"
    end
    expect(current_path).to eql("/register")
    fill_in :name, with: "Bob"
    fill_in :address, with: "333 Blvd"
    fill_in :city, with: "Denver"
    fill_in :state, with: "Colorado"
    fill_in :zip, with: 88832
    fill_in :email, with: "bob@gz.com"
    fill_in :password, with: "1234"
    fill_in :confirm_password, with: "1234"
    click_button "Create User"
    expect(current_path).to eql("/profile")
    expect(page).to have_content("You are now logged in Bob")
  end
end



  # jack = User.new ({
  #     name: "Jack",
  #     address: "333 Jack Blvd",
  #     city: "Denver",
  #     state: "Colorado",
  #     zip: 83243,
  #     email: "jack@hotmail.com",
  #     password: "3455"
  #   )}
# User Story 10, User Registration
#
# As a visitor
# When I click on the 'register' link in the nav bar
# Then I am on the user registration page ('/register')
# And I see a form where I input the following data:
# - my name
# - my street address
# - my city
# - my state
# - my zip code
# - my email address
# - my preferred password
# - a confirmation field for my password
#
# When I fill in this form completely,
# And with a unique email address not already in the system
# My details are saved in the database
# Then I am logged in as a registered user
# I am taken to my profile page ("/profile")
# I see a flash message indicating that I am now registered and logged in
