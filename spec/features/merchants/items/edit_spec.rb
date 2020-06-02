require 'rails_helper'

RSpec.describe "As a merchant employee, when I visit my items page" do
  it "I can edit any existing item" do
    dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    employee = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "john@hotmail.com", password: "3455", password_confirmation: "3455", role: 1, merchant_id: dog_shop.id})
    user = User.create!(name:"Jill", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email2@email.com", password: "abcd", password_confirmation:"abcd", role:0)
    pull_toy = dog_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32, active?: true)

    visit "/login"
    fill_in :email, with: "john@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"
    visit '/merchant/items'

    click_link("Edit Item")
    expect(current_path).to eq("/merchant/items/#{pull_toy.id}/edit")

    fill_in :name, with: "New Toy Name"
    fill_in :price, with: 4
    fill_in :description, with: "New description"
    fill_in :image, with: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/indoor-dog-toys-1587002073.jpg"
    fill_in :inventory, with: 10

    click_on "Update Item"

    expect(current_path).to eq("/merchant/items")

    expect(page).to have_content("New Toy Name")
    expect(page).to have_content("New description")
    expect(page).to have_content("Item has been updated.")
  end

  it "I cannot update an item if any field is invalid" do
    dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    employee = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "john@hotmail.com", password: "3455", password_confirmation: "3455", role: 1, merchant_id: dog_shop.id})
    user = User.create!(name:"Jill", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email2@email.com", password: "abcd", password_confirmation:"abcd", role:0)
    pull_toy = dog_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32, active?: true)

    visit "/login"
    fill_in :email, with: "john@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"
    visit '/merchant/items'

    click_link("Edit Item")
    expect(current_path).to eq("/merchant/items/#{pull_toy.id}/edit")

    fill_in :name, with: "New Toy Name"
    fill_in :price, with: 4
    fill_in :description, with: ""
    fill_in :image, with: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/indoor-dog-toys-1587002073.jpg"
    fill_in :inventory, with: 10

    click_on "Update Item"

    expect(current_path).to eq("/merchant/items/#{pull_toy.id}/edit")
    expect(page).to have_content("Description can't be blank")

    fill_in :name, with: "New Toy Name"
    fill_in :price, with: 0
    fill_in :description, with: "New description"
    fill_in :image, with: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/indoor-dog-toys-1587002073.jpg"
    fill_in :inventory, with: 10

    click_on "Update Item"

    expect(current_path).to eq("/merchant/items/#{pull_toy.id}/edit")
    expect(page).to have_content("Price must be greater than 0")

     fill_in :name, with: "New Toy Name"
    fill_in :price, with: 4
    fill_in :description, with: "New description"
    fill_in :image, with: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/indoor-dog-toys-1587002073.jpg"
    fill_in :inventory, with: 0

    click_on "Update Item"

    expect(current_path).to eq("/merchant/items/#{pull_toy.id}/edit")
    expect(page).to have_content("Inventory must be greater than 0")
  end
end
