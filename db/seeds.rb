# Clear existing data
User.destroy_all
Address.destroy_all
Book.destroy_all
Order.destroy_all
OrderItem.destroy_all

# List of relationship types to avoid Faker issue
relationship_types = ['Brother', 'Sister', 'Father', 'Mother', 'Spouse', 'Friend', 'Colleague']

# Create 6 books with random details
6.times do
  Book.create!(
      book_name: Faker::Book.title,
      language: Faker::Nation.language
  )
end

# Create 10 users with random details
2.times do
  bulk_user = User.create!(
      name: Faker::Name.name,
      relative_type: relationship_types.sample,
      relative_name: Faker::Name.name,
      mobile: Faker::PhoneNumber.cell_phone_in_e164.gsub(/[^\d]/, '')[1..10],
      gender: ['Male', 'Female'].sample,
      password: "123456",
      role: 'bulk_buyer' # Explicitly assign bulk_buyer role
  )

  # Create 1 to 3 random addresses for each bulk_buyer
  rand(1..3).times do
    bulk_user.addresses.create!(
        house_no: Faker::Address.building_number,
        landmark: Faker::Address.secondary_address,
        village: Faker::Address.community,
        post_office: Faker::Address.city,
        tehsil: Faker::Address.city,
        district: Faker::Address.city,
        state: Faker::Address.state,
        city: Faker::Address.city,
        pin_code: Faker::Number.number(digits: 6),
        address_type: ['Home', 'Work', 'Other'].sample,
        is_primary: [true, false].sample
    )
  end

  if bulk_user.can_order_multiple_books? # If the user is a bulk buyer, they can have multiple items
    # For bulk buyer, create 2-3 random order items
    # Create an order for the user
    order = Order.create!(user: bulk_user)
    rand(2..3).times do
      book = Book.order("RANDOM()").first # Pick a random book
      order_item = OrderItem.create!(
          order: order,
          book: book,
          quantity: rand(1..5) # Random quantity between 1 and 5
      )
    end
  end
end

# Create remaining 8 users as 'regular' users
8.times do
  user = User.create!(
      name: Faker::Name.name,
      relative_type: relationship_types.sample,
      relative_name: Faker::Name.name,
      mobile: Faker::PhoneNumber.cell_phone_in_e164.gsub(/[^\d]/, '')[1..10],
      gender: ['Male', 'Female'].sample,
      password: "123456",
      role: 'regular' # Assign regular role
  )

    # Create 1 to 3 random addresses for each user (adjust the number as needed)
    user.addresses.create!(
        house_no: Faker::Address.building_number,
        landmark: Faker::Address.secondary_address,
        village: Faker::Address.community,
        post_office: Faker::Address.city,
        tehsil: Faker::Address.city,
        district: Faker::Address.city,
        state: Faker::Address.state,
        city: Faker::Address.city,
        pin_code: Faker::Number.number(digits: 6), # Generate a 6-digit pin code
        address_type: ['Home', 'Work', 'Other'].sample,
        is_primary: [true, false].sample
    )

      # Based on user role, add order items
      order = user.orders.create!

      # For regular user, create 1 order item
      book = Book.order("RANDOM()").first # Pick a random book
      order_item = OrderItem.create!(
          order: order,
          book: book,
          quantity: rand(1..5) # Random quantity between 1 and 5
      )
end


puts "Seed data created successfully!"
