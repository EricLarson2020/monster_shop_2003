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
    fill_in :password_confirmation, with: "1234"
    click_button "Create User"
    expect(current_path).to eql("/profile")
    expect(page).to have_content("You are now logged in Bob")
  end

  it "Gives error if form not filled out completely" do
  visit "/merchants"
  within "nav" do
    click_link "register"
  end
  expect(current_path).to eql("/register")

  fill_in :address, with: "333 Blvd"
  fill_in :city, with: "Denver"
  fill_in :state, with: "Colorado"
  fill_in :zip, with: 88832
  fill_in :email, with: "bob@gz.com"
  fill_in :password, with: "1234"
  fill_in :password_confirmation, with: "1234"
  click_button "Create User"
  expect(current_path).to eql("/register")
  expect(page).to have_content("Name can't be blank")

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
  fill_in :password_confirmation, with: "1234"
  click_on "Create User"
  expect(current_path).to eql("/register")

  expect(page).to have_content("Password can't be blank")
end

  it "it gives an error if the password does not match password confirmation" do
    visit "/merchants"
    within "nav" do
      click_link "register"
    end
    fill_in :name, with: "Bob"
    fill_in :address, with: "333 Blvd"
    fill_in :city, with: "Denver"
    fill_in :state, with: "Colorado"
    fill_in :zip, with: 88832
    fill_in :email, with: "bob@gz.com"
    fill_in :password, with: "1234"
    fill_in :password_confirmation, with: "5678"
    click_button "Create User"
    expect(current_path).to eq("/register")
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  it "user has to use unique email" do

    jack = User.create!({
      name: "Jack",
      address: "333 Jack Blvd",
      city: "Denver",
      state: "Colorado",
      zip: 83243,
      email: "jack@hotmail.com",
      password: "3455",
      password_confirmation: "3455"
    })


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
    fill_in :email, with: "jack@hotmail.com"
    fill_in :password, with: "1234"
    fill_in :password_confirmation, with: "1234"
    click_button "Create User"
    expect(current_path).to eql("/register")
    expect(page).to have_content("Email has already been taken")
  end


end




# User Story 10, User Registration
#
# User Story 11, User Registration Missing Details
#
# As a visitor
# When I visit the user registration page
# And I do not fill in this form completely,
# I am returned to the registration page
# And I see a flash message indicating that I am missing required fields
