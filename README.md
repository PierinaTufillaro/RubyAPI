# Inventory-API

## :package: Requirements

1. Install ruby 2.5.7
2. Install Ruby on Rails

## :package:Endpoints which doesn't requires token
### Users 
   - **POST /users** Creates a new user. You have to send an email and a password through the body of the petition.

### Session
   - **POST /sessions** Creates a new session. You have to send an existing email and the correspondent password for            that email through the body of the petition. If the data is correct, you'll receive a token through the header of the        petition.
  
## :package: Endpoints which require token
### Session
  - **DEL  /sessions** Delate the actual session.

### Products
  - **GET  /products/all** Return all the products.
  
  - **GET  /products/scarce** Return all the products which stock is between one and five.
  
  - **GET  /products** Returns all the products which stock is more than zero.
  
  - **GET  /products/:codigo** Return all the information of the product which code is the same that the one sent through the URL. You have to send an existing product's code through the URL. If the product's code sent doesn't exist, then you'll receive an HTTP Status 404 'Not found'.
  
  - **GET  /products/:codigo/items** Return all the items associated with the product's code sent. You have to send an         existing product's code through the URL. If the product's code sent doesn't exist, then you'll receive an HTTP Status 404 'Not found'.
  
  - **POST /products/:codigo/items** Creates items for the product identified by the code received through the code             parameter. The body of the petition receive the quantity of items to create. (The quantity must be more than zero). All the new item's status will be 'available'.
  



Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
