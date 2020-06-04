### README

  For the database we have a one to many relationship between users and orders where a user can have many order but an order can only belong to a single user. There is a one to many relationship between items and reviews where items and have many reviews and reviews belong to an item. We created a many to many relationship between items and orders so that each has many of the other. Merhants and items have a one to many relationship where items belong to merchants and merchants have many items. There is also a one to many relationship between users and merchants where a merchant can have many users and a user can belong to a merchant

  We created fours types of users. Visitors have the least functionality and can only view items and merchants. Basic users can make orders. Merchants can fulfill orders, while admins can do everything and see everything.

  For the app users can make order, merchants can fulfill orders, and it ships an order when all items in the order are fulfilled, while adding to and subtracting from the inventory for the item and only allowing item orders with sufficient inventory to be fulfilled. A visitor can also make an account and login. They are assigned a status of default user. 
