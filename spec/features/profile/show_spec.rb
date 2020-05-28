require 'rails_helper'

RSpec.describe "Profile Show Page" do
  before(:each) do
    @jack = User.create!({
    name: "Jack",
    address: "333 Jack Blvd",
    city: "Denver",
    state: "Colorado",
    zip: 83243,
    email: "jjjjj@hotmail.com",
    password: "3455",
    password_confirmation: "3455",
    role: 0
    })

    visit "/login"
    fill_in :email, with: "jjjjj@hotmail.com"
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
        expect(page).to have_no_content(@jack.password)
      end
      expect(page).to have_button("Edit My Profile")
    end

    it 'when I click on edit profile, I can edit my information' do
      click_button("Edit My Profile")

      expect(current_path).to eq("/profile/#{@jack.id}/edit")

      expect(find_field('name').value).to eq "#{@jack.name}"
      expect(find_field('address').value).to eq "#{@jack.address}"
      expect(find_field('city').value).to eq "#{@jack.city}"
      expect(find_field('state').value).to eq "#{@jack.state}"
      expect(find_field('zip').value).to eq "#{@jack.zip}"
      expect(find_field('email').value).to eq "#{@jack.email}"

      fill_in :name, with: "new name"
      fill_in :address, with: "new address"
      fill_in :city, with: "new city"
      fill_in :state, with: "new state"
      fill_in :zip, with: 80110
      fill_in :email, with: "new_email@aol.com"

      click_button("Submit Update")

      expect(current_path).to eq("/profile")
      expect(page).to have_content("Your profile has been updated")
      expect(page).to have_content("new name")
      expect(page).to have_content("new address")
      expect(page).to have_content("new state")
      expect(page).to have_content(80110)
      expect(page).to have_content("new_email@aol.com")
      expect(page).to have_no_content("jjjjj@hotmail.com")
    end
  end
end


# User Story 20, User Can Edit their Profile Data
# As a registered user
# When I visit my profile page
# I see a link to edit my profile data
# When I click on the link to edit my profile data
# I see a form like the registration page
# The form is prepopulated with all my current information except my password
# When I change any or all of that information
# And I submit the form
# Then I am returned to my profile page
# And I see a flash message telling me that my data is updated
# And I see my updated information
