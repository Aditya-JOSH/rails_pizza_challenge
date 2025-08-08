# Pizza Order Management System

A Ruby on Rails application for managing pizza orders with support for customizations, promotions, and discounts.

## Features

- View and manage pizza orders
- Support for multiple pizza sizes with price multipliers
- Customizable ingredients (add/remove)
- Promotion codes (e.g., 2-for-1 deals)
- Discount codes (percentage-based)
- Order completion tracking
- Pagination for orders listing

## Technical Stack

- Ruby 3.4.5
- Rails 8.0.2
- SQLite3 database
- RSpec for testing
- Bootstrap 5 for UI
- Kaminari for pagination

## Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd pizza_challenge
```

2. Install dependencies:
```bash
bundle install
```

3. Setup database:
```bash
rails db:create
rails db:migrate
rails db:seed
```

4. Run the server:
```bash
rails server
```

5. Visit `http://localhost:3000` in your browser

## Database Structure

- **Orders**: Main order information with state and total
- **OrderItems**: Individual pizza items in an order
- **ItemIngredients**: Customizations for each order item
- **Pizzas**: Available pizza types and base prices
- **Ingredients**: Available ingredients and prices
- **PromotionCodes**: Available promotions (e.g., 2-for-1)
- **DiscountCodes**: Percentage-based discounts
- **OrderPromotions**: Join table for orders and promotions

## Price Calculation

The system calculates prices based on:
1. Base pizza price
2. Size multiplier (Small: 0.7x, Medium: 1.0x, Large: 1.3x)
3. Extra ingredients (price × size multiplier)
4. Applicable promotions (e.g., 2-for-1)
5. Discount codes (percentage off total)

## Testing

The project uses RSpec for testing. Run the test suite with:

```bash
bundle exec rspec
```

Test coverage includes:
- Model specs (associations, validations, methods)
- Controller specs (actions, responses)

## Configuration

Key configuration files:
- `config/database.yml` - Database configuration
- `data/config.yml` - Pizza, ingredient, and promotion configurations
- `data/orders.json` - Sample order data

## API Endpoints

### Orders

- `GET /orders` - List all open orders
- `PATCH /orders/:uuid` - Mark an order as completed

Response formats: HTML and JSON

## Run all tests:
```bash
bundle exec rspec
```

### Code Style

The project follows Ruby on Rails best practices and uses:
- RuboCop for Ruby style enforcement

Run style checks with:
```bash
bundle exec rubocop
```
