require "rails_helper"

RSpec.describe "Profile Index Page", type: :feature do
  it "Can get to profile page if logged in" do
  jack = User.create!({
    name: "Jack",
    address: "333 Jack Blvd",
    city: "Denver",
    state: "Colorado",
    zip: 83243,
    email: "jjjjj",
    password: "3455",
    password_confirmation: "3455",
    role: 2
    })

    visit "/login"
    fill_in :email, with: "jjjjj"
    fill_in :password, with: "3455"
    click_on "Submit"
    visit "/"
    within ".topnav" do
      click_link("Profile Page")
    end
    expect(current_path).to eql("/profile")
  end

    it "does not see profile page link when not logged in" do
      visit "/"
      within ".topnav" do
        expect(page).not_to have_css("Profile Page")
      end
    end
  end
