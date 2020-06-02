require 'rails_helper'

RSpec.describe "As a merchant employee, when I visit my items page" do
  it "I can click a link to add a new item" do
    dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    employee = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "john@hotmail.com", password: "3455", password_confirmation: "3455", role: 1, merchant_id: dog_shop.id})

    visit "/login"
    fill_in :email, with: "john@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"
    visit '/merchant/items'

    click_link("Add New Item")
    expect(current_path).to eq("/merchant/items/new")

    fill_in :name, with: "New Toy"
    fill_in :price, with: 3
    fill_in :description, with: "This is a new toy"
    fill_in :image, with: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/indoor-dog-toys-1587002073.jpg"
    fill_in :inventory, with: 2

    click_on "Create Item"
    expect(current_path).to eq("/merchant/items")
    new_item = dog_shop.items.last
    expect(page).to have_content("New Toy has been saved.")
    expect(page).to have_content(new_item.name)
    expect(page).to have_content(new_item.price)
    expect(page).to have_content(new_item.description)
    expect(page).to have_content(new_item.inventory)
  end

  it "Cannot add new item with invalid fields" do
    dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    employee = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "john@hotmail.com", password: "3455", password_confirmation: "3455", role: 1, merchant_id: dog_shop.id})

    visit "/login"
    fill_in :email, with: "john@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"
    visit '/merchant/items'

    click_link("Add New Item")

    fill_in :name, with: ""
    fill_in :price, with: 3
    fill_in :description, with: "This is a new toy"
    fill_in :image, with: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/indoor-dog-toys-1587002073.jpg"
    fill_in :inventory, with: 2

    click_on "Create Item"
    expect(current_path).to eq("/merchant/items/new")
    expect(page).to have_content("Name can't be blank")
  end

  it "Item has a default image if none is provided when creating" do
    dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    employee = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "john@hotmail.com", password: "3455", password_confirmation: "3455", role: 1, merchant_id: dog_shop.id})

    visit "/login"
    fill_in :email, with: "john@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"
    visit '/merchant/items'

    click_link("Add New Item")

    fill_in :name, with: "New Toy"
    fill_in :price, with: 3
    fill_in :description, with: "This is a new toy"
    fill_in :image, with: ""
    fill_in :inventory, with: 2

    click_on "Create Item"
    expect(current_path).to eq("/merchant/items")
    # expect(page).to have_content("Name can't be blank")
    # how to search page to find css
  end
end


# I see a link to add a new item
# When I click on the link to add a new item
# I see a form where I can add new information about an item, including:
# - the name of the item, which cannot be blank
# - a description for the item, which cannot be blank
# - a thumbnail image URL string, which CAN be left blank
# - a price which must be greater than $0.00
# - my current inventory count of this item which is 0 or greater

# When I submit valid information and submit the form
# I am taken back to my items page
# I see a flash message indicating my new item is saved
# I see the new item on the page, and it is enabled and available for sale
# If I left the image field blank, I see a placeholder image for the thumbnail