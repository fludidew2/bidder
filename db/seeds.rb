# db/seeds.rb

# Clear existing data
User.destroy_all
Request.destroy_all

# Create buyers
buyers = []
5.times do |i|
  buyers << User.create!(
    email: "buyer#{i+1}@example.com",
    password: 'password',
    password_confirmation: 'password',
    role: :buyer
  )
end

# Create vendors
vendors = []
5.times do |i|
  vendors << User.create!(
    email: "vendor#{i+1}@example.com",
    password: 'password',
    password_confirmation: 'password',
    role: :vendor
  )
end

# Create requests for each buyer
buyers.each do |buyer|
  3.times do |i|
    Request.create!(
      description: "test description",
      status: :open,
      user: buyer
    )
  end
end

puts "Seeded #{User.count} users (#{buyers.count} buyers and #{vendors.count} vendors) and #{Request.count} requests."