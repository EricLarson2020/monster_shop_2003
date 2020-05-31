require 'rails_helper'

RSpec.describe "Items Index Page" do
  describe "When I visit the items index page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @pull_toy = @brian.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create!(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      @tennis_ball = @brian.items.create!(name: "Tennis Ball", description: "Great ball!", price: 5, image: "http://lovencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 40)
      @racket = @brian.items.create!(name: "Tennis Racket", description: "Great Tennis Racket!", price: 200, image: "http://lvencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 10)
      @bell = @meg.items.create!(name: "Bell", description: "They will hear you comming", price: 30, image: "https://www.ri.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 9)
      @helmet = @meg.items.create!(name: "Helmet", description: "Keep that head of yours safe", price: 150, image: "https://www.ri.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 32)
    end

    it "all items or merchant names are links" do
      visit '/items'

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@tire.merchant.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_link(@pull_toy.merchant.name)
    end

    it "I can see a list of all of the items "do

      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end

      expect(page).to_not have_content(@dog_bone.name)
      expect(page).to_not have_content(@dog_bone.description)
      expect(page).to_not have_content(@dog_bone.price)
    end

    it "user can see statistics for most popular and least popular items" do

        jack = User.create ({name: "Jack", address: "333 Jack Blvd", city: "Denver", state: "Colorado", zip: 83243, email: "777@hotmail.com", password: "3455"})
        order1 = Order.create!(name: "jack", address: "1234 something", city: "Den", state: "CO", zip: 12344, user_id: jack.id)
        order2 = Order.create!(name: "john", address: "1234 something", city: "Den", state: "CO", zip: 12344, user_id: jack.id)


        ItemOrder.create!(item_id: @tire.id, order_id: order1.id, price: 5.00, quantity: 5)
        ItemOrder.create!(item_id: @pull_toy.id, order_id: order1.id, price: 5.00, quantity: 6)
        ItemOrder.create!(item_id: @tennis_ball.id, order_id: order1.id, price: 5.00, quantity: 4)
        ItemOrder.create!(item_id: @helmet.id, order_id: order1.id, price: 5.00, quantity: 1)
        ItemOrder.create!(item_id: @bell.id, order_id: order1.id, price: 5.00, quantity: 2)
        ItemOrder.create!(item_id: @racket.id, order_id: order1.id, price: 200.00, quantity: 3)
        ItemOrder.create!(item_id: @racket.id, order_id: order2.id, price: 200.00, quantity: 4)

        visit "/items"


        within ".statistics" do
          within ".top_five" do
            expect(page).to have_content("Racket, Quantity: 7")
            expect(page).to have_content("Pull Toy, Quantity: 6")
            expect(page).to have_content("Gatorskins, Quantity: 5")
            expect(page).to have_content("Tennis Ball, Quantity: 4")
            expect(page).to have_content("Bell, Quantity: 2")
          end
          within ".bottom_five" do
            expect(page).to have_content("Helmet, Quantity: 1")
            expect(page).to have_content("Bell, Quantity: 2")
            expect(page).to have_content("Tennis Ball, Quantity: 4")
            expect(page).to have_content("Gatorskins, Quantity: 5")
            expect(page).to have_content("Pull Toy, Quantity: 6")
          end
        end

    end
  end
end
