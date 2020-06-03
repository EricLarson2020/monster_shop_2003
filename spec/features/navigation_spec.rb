
require 'rails_helper'

RSpec.describe 'Site Navigation' do
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
  end
end
