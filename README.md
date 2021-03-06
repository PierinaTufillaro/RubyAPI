# :package: InventoryAPI :package:
   API is created to keep track the inventory of your bussiness. You can register products, items, sells, reservations, clients data and different users. 

   Some endpoints that require a token. You must create a new session and that one will create a new token. You have to pass that token through the header parameter named 'Authorization' on every endpoint that requires a token. For security, sessions last 40 minutes. After that, you have to sing in again.
   
## :package: Requirements

1. ruby 2.5.7
2. bundler gem

## :package: How to run the API

1. Open a terminal
2. Go to the API directory
3. Run `bundle install` to get all the required gems
4. Run `rake db:create` to create the database
5. Run `rake db:migrate` to fill the database 
6. Run `rails server` to start the web server
7. Go to http://localhost:3000/
8. Enjoy it :wink:!

## :package: Endpoints 
### Users (not requires token)
   - **POST /users** Creates a new user. You have to send an email and a password through the body of the petition.

### Session 
   - **POST /sessions** Creates a new session. You have to send an existing email and the correspondent password for            that 
   email through the body of the petition. If the data is correct, you will receive a token through the header of the        petition. **(does not require token)**

  - **DEL  /sessions** Deletes the actual session.**(requires token)**

### Products (require token)
  - **GET  /products/all** Returns all the products.
  
  - **GET  /products/scarce** Returns all the products which stock is between one and five.
  
  - **GET  /products** Returns all the products which stock is more than zero.
  
  - **GET  /products/:codigo** Returns all the information of the product which code is the same that the one was sent through the   
  URL. You have to send an existing product's code through the URL. If the product's code sent does not exist, then you will       
  receive an HTTP Status 404 'Not found'.
  
  - **GET  /products/:codigo/items** Return all the items associated with the product's code sent. You have to send an         existing 
  product's code through the URL. If the product's code sent doesn't exist, then you will receive an HTTP Status 404     'Not found'.
  
  - **POST /products/:codigo/items** Creates items for the product identified by the code received through the code             
  parameter. The body of the petition receive the quantity of items to create. (The quantity must be more than zero). All the   new 
  item's status will be 'available'.
  
### Reservations (require token)
   - **GET  /reservation** Return all the reservations that have not been sold yet.
   
   - **GET  /reservation/:id** Return the information of the reservation indentified by the ID sent through the ID parameter.
   
   - **POST /reservations** Creates a reservation with the attributes which were sent as parameters in the body of the petition. You        must send the attributes in JSON:API format. It will include the code and quantity of the products that the reservation apply for. If 
   there is an error in the validation, the reservation will not be created.
   
   - **PUT /reservations/:id/sell** Creates a sell for the identified reservation by the ID sent through the ID parameter,      just in 
   the case that the sell does not exist.
   
   - **DELETE /reservations/:id** Deletes an existing reservation identified by the ID sent through the ID parameter. All the    items 
   associated with that reservation will be updated with an 'available' status. The reservation must not be sold.

### Sells (require token)
   - **GET /sells** Returns all the sells created by the actual user. It shows the date, the name and the total amount of the    sales.
   
   - **GET /sells/:id** Returns all the information of the identified sell by the parameter called ID. If      the sell was not  
   registered by the actual user, you would receive an HTTP Status 404 'Not found'. If you want to include      the items associated to 
   the sell, you have to do it through a compound document. 
   
   - **POST /sells** Creates a sell with the attributes which were sent as parameters in the body of the petition. You must send the        attributes in JSON:API format. It will include the code and quantity of the products that the sell apply for. If there is an error in 
   the validation, the sell will not be created.
   
   ## :package: How to run the tests

1. Open a terminal
2. Go to the API directory
3. Run `rails test`
4. Check it :ok_hand:!
