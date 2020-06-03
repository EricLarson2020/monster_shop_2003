require 'rails_helper'

RSpec.describe "As a Admin employee, when I visit my items page" do
  it "I can click a link to add a new item" do
    dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    employee = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "doggy@hotmail.com", password: "3455", password_confirmation: "3455", role: 2, merchant_id: dog_shop.id})

    visit "/login"
    fill_in :email, with: "doggy@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"
    visit "/admin/merchants/#{dog_shop.id}/items"

    click_link("Add New Item")
    expect(current_path).to eq("/admin/merchants/#{dog_shop.id}/items/new")

    fill_in :name, with: "New Toy"
    fill_in :price, with: 3
    fill_in :description, with: "This is a new toy"
    fill_in :image, with: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/indoor-dog-toys-1587002073.jpg"
    fill_in :inventory, with: 2

    click_on "Create Item"
    expect(current_path).to eq("/admin/merchants/#{dog_shop.id}/items")
    new_item = dog_shop.items.last
    expect(page).to have_content("New Toy has been saved.")
    expect(page).to have_content(new_item.name)
    expect(page).to have_content(new_item.price)
    expect(page).to have_content(new_item.description)
    expect(page).to have_content(new_item.inventory)
  end

  it "Cannot add new item with invalid fields" do
    dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    employee = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "fishy@hotmail.com", password: "3455", password_confirmation: "3455", role: 2, merchant_id: dog_shop.id})

    visit "/login"
    fill_in :email, with: "fishy@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"
    visit "/admin/merchants/#{dog_shop.id}/items"

    click_link("Add New Item")

    fill_in :name, with: ""
    fill_in :price, with: 3
    fill_in :description, with: "This is a new toy"
    fill_in :image, with: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/indoor-dog-toys-1587002073.jpg"
    fill_in :inventory, with: 2

    click_on "Create Item"
    expect(current_path).to eq("/admin/merchants/#{dog_shop.id}/items/new")
    expect(page).to have_content("Name can't be blank")
  end

  it "Item has a default image if none is provided when creating" do
    dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    employee = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "fishing@hotmail.com", password: "3455", password_confirmation: "3455", role: 2, merchant_id: dog_shop.id})

    visit "/login"
    fill_in :email, with: "fishing@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"
    visit "/admin/merchants/#{dog_shop.id}/items"

    click_link("Add New Item")

    fill_in :name, with: "New Toy"
    fill_in :price, with: 3
    fill_in :description, with: "This is a new toy"
    fill_in :image, with: ""
    fill_in :inventory, with: 2

    click_on "Create Item"
    expect(current_path).to eq("/admin/merchants/#{dog_shop.id}/items")
    expect(page).to have_css("img[src*='https://cdn.dribbble.com/users/120891/screenshots/4649285/dribble_42.png']")
  end
end
