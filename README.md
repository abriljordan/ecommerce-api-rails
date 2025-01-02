Here’s a summary of all the CLI commands used and the features accomplished in the e-commerce API project.

CLI Commands Used

Project Initialization

rails new ecommerce_api --api
cd ecommerce_api
bundle install

Database Setup

rails db:create
rails db:migrate
rails generate model User email:string password_digest:string
rails generate model Product name:string price:decimal
rails generate model Cart user:references
rails generate model CartItem cart:references product:references quantity:integer

Controllers Generation

rails generate controller api/v1/users create
rails generate controller api/v1/sessions create
rails generate controller api/v1/products
rails generate controller api/v1/carts
rails generate controller api/v1/cart_items
rails generate controller api/v1/checkout create

Authentication (JWT)

# Generate a secret key for JWT
rails secret

Routes and Migration Updates

rails db:migrate

Testing API Endpoints (Curl Commands)

User Authentication

# Login
curl -X POST "http://127.0.0.1:3000/api/v1/login" \
  -H "Content-Type: application/json" \
  -d '{"email": "user@example.com", "password": "password"}'

Products

# Create Product
curl -X POST "http://127.0.0.1:3000/api/v1/products" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{"product": {"name": "Laptop", "price": 1099.99}}'

# List Products
curl -X GET "http://127.0.0.1:3000/api/v1/products" \
  -H "Authorization: Bearer <token>"

Cart Management

# Add Item to Cart
curl -X POST "http://127.0.0.1:3000/api/v1/carts/1/cart_items" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{"cart_item": {"product_id": 3, "quantity": 2}}'

# View Cart
curl -X GET "http://127.0.0.1:3000/api/v1/carts/1" \
  -H "Authorization: Bearer <token>"

Checkout

# Checkout Cart
curl -X POST "http://127.0.0.1:3000/api/v1/carts/1/checkout" \
  -H "Authorization: Bearer <token>"

Features Accomplished

1. User Authentication
    •   JWT-based user authentication.
    •   Secure login system using encrypted passwords.

2. Product Management
    •   CRUD operations for products.
    •   Protected endpoints for admin users.

3. Cart Management
    •   Add, view, and remove items in a user’s cart.
    •   Associate carts with users and track cart items.

4. Checkout
    •   Process payment for items in the cart (dummy payment integration).
    •   Calculate total cost and mark carts as checked out.

5. API Security
    •   JWT tokens for securing endpoints.
    •   Role-based access control (e.g., admin vs. user).

6. JSON API Response
    •   Consistent JSON responses across all endpoints.
    •   Detailed error messages for invalid requests.

How to Run the API
1. Install Dependencies:

bundle install

2. Setup the Database:

rails db:create
rails db:migrate

3. Start the Server:

rails server

4. Test the API Endpoints:
Use tools like Postman or curl to test endpoints.

