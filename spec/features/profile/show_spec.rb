require 'rails_helper'

RSpec.describe "Profile Show Page" do
  before(:each) do
    @jack = User.create!({
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
    visit "/profile"
  end

  describe 'as a registered user when I visit my profile page' do
    it 'can see my profile data except password' do
      within '.user-info' do
        expect(page).to have_content(@jack.name)
        expect(page).to have_content(@jack.address)
        expect(page).to have_content(@jack.city)
        expect(page).to have_content(@jack.state)
        expect(page).to have_content(@jack.zip)
        expect(page).to have_content(@jack.email)
        save_and_open_page
      end
    end
  end
end

# User Story 19, User Profile Show Page

# As a registered user
# When I visit my profile page
# Then I see all of my profile data on the page except my password
# And I see a link to edit my profile data