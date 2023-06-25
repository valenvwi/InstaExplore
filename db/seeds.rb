require 'faker'

puts "Creating users..."
User.create(first_name: "Lai Fun", last_name: "Chu", username: "Laifunpig", bio: "Bababababaaa", location: "England", email:"user1@example.com", password:"123456")
User.create(first_name: "Cris", last_name: "Baby", username: "iamyourbaby", bio: "Chill", location: "Zurich", email:"user2@example.com", password: "123456")
puts "Done"

puts "Creating fake users..."
num = 3
10.times do
  user = User.new(
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.last_name,
    username: Faker::Internet.unique.username,
    bio: Faker::TvShows::Simpsons.quote,
    location: Faker::Address.city,
    email: "user#{num}@example.com",
    password: "123456"
  )
  num += 1
  user.save!
end

puts "Done"
