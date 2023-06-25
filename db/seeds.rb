require 'faker'

puts "Creating users..."
User.create(first_name: "Lai Fun", last_name: "Chu", username: "Laifunpig", bio: "Bababababaaa", location: "England")
User.create(first_name: "Cris", last_name: "Baby", username: "iamyourbaby", bio: "Chill", location: "Zurich")
puts "Done"

puts "Creating fake users..."
10.times do
  user = User.new(
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.last_name,
    username: Faker::Internet.unique.username,
    bio: Faker::TvShows::Simpsons.quote,
    location: Faker::Address.city
  )
  user.save!
end

puts "Done"
