# db/seeds.rb

# Clear existing data
User.destroy_all
Address.destroy_all
Book.destroy_all

# List of relationship types to avoid Faker issue
relationship_types = ['Brother', 'Sister', 'Father', 'Mother', 'Spouse', 'Friend', 'Colleague']

# Create 10 users with random details
10.times do
  user = User.create!(
      name: Faker::Name.name,
      relative_type: relationship_types.sample,  # Pick a random relationship type from the list
      relative_name: Faker::Name.name,
      mobile: Faker::PhoneNumber.cell_phone_in_e164,
      gender: ['Male', 'Female'].sample
  )

  # Create 1 to 3 random addresses for each user (adjust the number as needed)
  rand(1..3).times do
    user.addresses.create!(
        house_no: Faker::Address.building_number,
        landmark: Faker::Address.secondary_address,
        village: Faker::Address.community,
        post_office: Faker::Address.city,
        tehsil: Faker::Address.city,
        district: Faker::Address.city,
        state: Faker::Address.state,
        city: Faker::Address.city,
        pin_code: Faker::Number.number(digits: 6),  # Generate a 6-digit pin code
        address_type: ['Home', 'Work', 'Other'].sample,
        is_primary: [true, false].sample
    )
  end
end

# Create 6 books with random details
6.times do
  Book.create!(
      book_name: Faker::Book.title,
      language: Faker::Nation.language
  )
end

puts "Seed data created successfully!"
