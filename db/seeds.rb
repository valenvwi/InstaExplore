require 'faker'
require 'fake_picture'
require "open-uri"

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
  user.avatar.attach(io: URI.open(Faker::Avatar.image), filename: "nes.png", content_type: "image/png")
  user.save!
end

puts "Done"


puts "creating posts"
20.times do
  post = Post.new(
    title: Faker::TvShows::FamilyGuy.quote,
    description: Faker::TvShows::Friends.quote,
    location: Faker::Address.city,
    user: User.find_by(id: rand(1..12))
  )
  post.images.attach(io: URI.open(FakePicture::Blog.preview), filename: "nes.png", content_type: "image/png")
  post.save!
end
