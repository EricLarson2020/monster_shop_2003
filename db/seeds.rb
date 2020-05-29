# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Merchant.destroy_all
Item.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
tennis_ball = dog_shop.items.create!(name: "Tennis Ball", description: "Great ball!", price: 5, image: "http://lovencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 40)
racket = dog_shop.items.create!(name: "Tennis Racket", description: "Great Tennis Racket!", price: 200, image: "http://lvencaretoys.com/image/cache/dog/tu-toy-dog-pull-9010_2-800x800.jpg", inventory: 10)
bell = dog_shop.items.create!(name: "Bell", description: "They will hear you comming", price: 30, image: "https://www.ri.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 9)
helmet = dog_shop.items.create!(name: "Helmet", description: "Keep that head of yours safe", price: 150, image: "https://www.ri.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 32)

order1 = Order.create!(name: "jack", address: "1234 something", city: "Den", state: "CO", zip: 12344)
order2 = Order.create!(name: "john", address: "1234 something", city: "Den", state: "CO", zip: 12344)


ItemOrder.create!(item_id: tire.id, order_id: order1.id, price: 5.00, quantity: 5)
ItemOrder.create!(item_id: pull_toy.id, order_id: order1.id, price: 5.00, quantity: 6)
ItemOrder.create!(item_id: tennis_ball.id, order_id: order1.id, price: 5.00, quantity: 4)
ItemOrder.create!(item_id: helmet.id, order_id: order1.id, price: 5.00, quantity: 1)
ItemOrder.create!(item_id: bell.id, order_id: order1.id, price: 5.00, quantity: 2)
ItemOrder.create!(item_id: racket.id, order_id: order1.id, price: 200.00, quantity: 3)
ItemOrder.create!(item_id: racket.id, order_id: order2.id, price: 200.00, quantity: 4)
