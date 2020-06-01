require 'rails_helper'

RSpec.describe "As a merchant employee, when I visit my items page" do
  it "I can see all of my items with info and status" do
    dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    employee = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "john@hotmail.com", password: "3455", password_confirmation: "3455", role: 1, merchant_id: dog_shop.id})
    pull_toy = dog_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    tennis_ball = dog_shop.items.create!(name: "Tennis Ball", description: "Great ball!", price: 5, image: "http://lovencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 40)
    racket = dog_shop.items.create!(name: "Tennis Racket", description: "Great Tennis Racket!", price: 200, image: "http://lvencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 10)

    visit "/login"
    fill_in :email, with: "john@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"
    visit '/merchant/items'

    within(".item-#{pull_toy.id}") do
      expect(page).to have_content(pull_toy.name)
      expect(page).to have_content(pull_toy.description)
      expect(page).to have_content(pull_toy.price)
      expect(page).to have_content(pull_toy.inventory)
      expect(page).to have_button("Deactivate Item")
    end
  end

  it "I can click link to change active status to inactive" do
    dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    employee = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "john@hotmail.com", password: "3455", password_confirmation: "3455", role: 1, merchant_id: dog_shop.id})
    pull_toy = dog_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32, active?: true)
    tennis_ball = dog_shop.items.create!(name: "Tennis Ball", description: "Great ball!", price: 5, image: "http://lovencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 40, active?: true)
    racket = dog_shop.items.create!(name: "Tennis Racket", description: "Great Tennis Racket!", price: 200, image: "http://lvencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 10, active?: true)

    visit "/login"
    fill_in :email, with: "john@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"
    visit merchant_items_path

    within(".item-#{pull_toy.id}") do
      click_button("Deactivate Item", match: :first)
    end

    expect(current_path).to eq("/merchant/items")
    expect(page).to have_content("#{pull_toy.name} is no longer for sale.")
  end

  it "I can click link to change inactive status to active" do
    dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    employee = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "john@hotmail.com", password: "3455", password_confirmation: "3455", role: 1, merchant_id: dog_shop.id})
    pull_toy = dog_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32, active?: true)
    tennis_ball = dog_shop.items.create!(name: "Tennis Ball", description: "Great ball!", price: 5, image: "http://lovencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 40, active?: false)
    racket = dog_shop.items.create!(name: "Tennis Racket", description: "Great Tennis Racket!", price: 200, image: "http://lvencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 10, active?: true)

    visit "/login"
    fill_in :email, with: "john@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"
    visit merchant_items_path

    within(".item-#{tennis_ball.id}") do
      click_button("Activate Item", match: :first)
    end

    expect(current_path).to eq("/merchant/items")
    expect(page).to have_content("#{tennis_ball.name} is now for sale.")
  end
end
