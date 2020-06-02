require 'rails_helper'

RSpec.describe "As an admin user" do
  it "I can see everything a merchant can see on their dashboard" do
    dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    employee = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "john@hotmail.com", password: "3455", password_confirmation: "3455", role: 1, merchant_id: dog_shop.id})
    user = User.create!(name:"Jill", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email2@email.com", password: "abcd", password_confirmation:"abcd", role:0)
    admin = User.create!(name:"Jan", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email@email.com", password: "abcd", password_confirmation:"abcd", role:2)

    pull_toy = dog_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    tennis_ball = dog_shop.items.create!(name: "Tennis Ball", description: "Great ball!", price: 5, image: "http://lovencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 40)
    racket = dog_shop.items.create!(name: "Tennis Racket", description: "Great Tennis Racket!", price: 200, image: "http://lvencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 10)

    order1 = Order.create!(name: "jack", address: "1234 something", city: "Den", state: "CO", zip: 12344, user: user)

    order1.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 2)
    order1.item_orders.create!(item: tennis_ball, price: tennis_ball.price, quantity: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/login"
    fill_in :email, with: "email@email.com"
    fill_in :password, with: "abcd"
    click_on "Submit"

    visit '/merchants'
    click_on "Dog Shop"

    expect(current_path).to eq("/admin/merchants/#{dog_shop.id}")
    expect(page).to have_content(order1.id)
    expect(page).to have_link("#{order1.id}")
    expect(page).to have_content("Total Quantity: 2")
    expect(page).to have_content("Total Value: $20")
  end
  it "I can disable merchant accounts" do

    dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210, status: "enabled")
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203, status: "disabled")

    employee = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "john@hotmail.com", password: "3455", password_confirmation: "3455", role: 1, merchant_id: dog_shop.id})
    user = User.create!(name:"Jill", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email2@email.com", password: "abcd", password_confirmation:"abcd", role:0)
    admin = User.create!(name:"Jan", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email@email.com", password: "abcd", password_confirmation:"abcd", role:2)

    pull_toy = dog_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    tennis_ball = dog_shop.items.create!(name: "Tennis Ball", description: "Great ball!", price: 5, image: "http://lovencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 40)
    racket = dog_shop.items.create!(name: "Tennis Racket", description: "Great Tennis Racket!", price: 200, image: "http://lvencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 10)
    toy = meg.items.create!(name: "Toy", description: "Great Tennis Racket!", price: 200, image: "http://lvencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 10)

    order1 = Order.create!(name: "jack", address: "1234 something", city: "Den", state: "CO", zip: 12344, user: user)
    order1.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 2)
    order1.item_orders.create!(item: tennis_ball, price: tennis_ball.price, quantity: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit "/login"
    fill_in :email, with: "email@email.com"
    fill_in :password, with: "abcd"
    click_on "Submit"
    visit "/admin/merchants"
    expect(current_path).to eql("/admin/merchants")

    within ".merchant-#{meg.id}" do
    expect(page).not_to have_button("disable")
  end

    within ".merchant-#{dog_shop.id}" do
      expect(page).to have_content("Merchant Status: enabled")
      click_button "disable"
    end

  expect(current_path).to eql("/admin/merchants")
  expect(page).to have_content("You have disable merchant #{dog_shop.id}")

  within ".merchant-#{dog_shop.id}" do
    expect(page).not_to have_button("disable")
    expect(page).to have_content("Merchant Status: disabled")
  end
end
  it "I deactivate items as I disable merchants" do
    dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210, status: "enabled")

    employee = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "john@hotmail.com", password: "3455", password_confirmation: "3455", role: 1, merchant_id: dog_shop.id})
    user = User.create!(name:"Jill", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email2@email.com", password: "abcd", password_confirmation:"abcd", role:0)
    admin = User.create!(name:"Jan", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "bblk@email.com", password: "abcd", password_confirmation:"abcd", role:2)

    pull_toy = dog_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    tennis_ball = dog_shop.items.create!(name: "Tennis Ball", description: "Great ball!", price: 5, image: "http://lovencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 40)
    racket = dog_shop.items.create!(name: "Tennis Racket", description: "Great Tennis Racket!", price: 200, image: "http://lvencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 10)


    order1 = Order.create!(name: "jack", address: "1234 something", city: "Den", state: "CO", zip: 12344, user: user)
    order1.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 2)
    order1.item_orders.create!(item: tennis_ball, price: tennis_ball.price, quantity: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit "/login"
    fill_in :email, with: "bblk@email.com"
    fill_in :password, with: "abcd"
    click_on "Submit"
    visit "/admin/merchants"

    within ".item-#{pull_toy.id}" do
      expect(page).to have_content("Item Active?: true")
    end

    within ".item-#{tennis_ball.id}" do
        expect(page).to have_content("Item Active?: true")
    end

    within ".item-#{racket.id}" do
      expect(page).to have_content("Item Active?: true")
    end

    within ".merchant-#{dog_shop.id}" do
    click_button "disable"
    end
    expect(current_path).to eql("/admin/merchants")
    within ".item-#{pull_toy.id}" do
      expect(page).to have_content("Item Active?: false")
    end

    within ".item-#{tennis_ball.id}" do
        expect(page).to have_content("Item Active?: false")
    end

    within ".item-#{racket.id}" do
      expect(page).to have_content("Item Active?: false")
    end
  end

  it "Can enable a disabled merchant and enable that merchants items" do
  dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210, status: "disabled")

  employee = User.create!({ name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "john@hotmail.com", password: "3455", password_confirmation: "3455", role: 1, merchant_id: dog_shop.id})
  user = User.create!(name:"Jill", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email2@email.com", password: "abcd", password_confirmation:"abcd", role:0)
  admin = User.create!(name:"Jan", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "nmnm@email.com", password: "abcd", password_confirmation:"abcd", role:2)

  pull_toy = dog_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32, active?: false)
  tennis_ball = dog_shop.items.create!(name: "Tennis Ball", description: "Great ball!", price: 5, image: "http://lovencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 40, active?: false)
  racket = dog_shop.items.create!(name: "Tennis Racket", description: "Great Tennis Racket!", price: 200, image: "http://lvencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 10, active?: false)


  order1 = Order.create!(name: "jack", address: "1234 something", city: "Den", state: "CO", zip: 12344, user: user)
  order1.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 2)
  order1.item_orders.create!(item: tennis_ball, price: tennis_ball.price, quantity: 1)
  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  visit "/login"
  fill_in :email, with: "nmnm@email.com"
  fill_in :password, with: "abcd"
  click_on "Submit"
  visit "/admin/merchants"


  within ".item-#{pull_toy.id}" do
    expect(page).to have_content("Item Active?: false")
  end

  within ".item-#{tennis_ball.id}" do
      expect(page).to have_content("Item Active?: false")
  end

  within ".item-#{racket.id}" do
    expect(page).to have_content("Item Active?: false")
  end

  within ".merchant-#{dog_shop.id}" do
  expect(page).to have_content("Merchant Status: disabled")
  click_button ("enable")
  end

  expect(current_path).to eql("/admin/merchants")
  expect(page).to have_content("You have enabled merchant #{dog_shop.id}")
  within ".merchant-#{dog_shop.id}" do
  expect(page).to have_content("Merchant Status: enabled")
  expect(page).not_to have_button("enable")
  end

  within ".item-#{pull_toy.id}" do
    expect(page).to have_content("Item Active?: true")
  end

  within ".item-#{tennis_ball.id}" do
      expect(page).to have_content("Item Active?: true")
  end

  within ".item-#{racket.id}" do
    expect(page).to have_content("Item Active?: true")
  end
end

end









# User Story 40, Admin enables a merchant account
#
# As an admin
# When I visit the merchant index page
# I see an "enable" button next to any merchants whose accounts are disabled
# When I click on the "enable" button
# I am returned to the admin's merchant index page where I see that the merchant's account is now enabled
# And I see a flash message that the merchant's account is now enabled
