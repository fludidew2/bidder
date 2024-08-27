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

puts "Seeded #{User.count} users and #{Request.count} requests."# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
