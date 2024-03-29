require 'faker'
require 'fake_picture'
require "open-uri"

puts "Creating users..."
user1 = User.create(first_name: "Lai Fun", last_name: "Chu", username: "Laifunpig", bio: "Bababababaaa", location: "England", email:"user1@example.com", password:"123456")
user1.save!
user2 = User.create(first_name: "Cris", last_name: "Baby", username: "iamyourbaby", bio: "Chill", location: "Zurich", email:"user2@example.com", password: "123456")
user2.save!
puts "Done"

puts "Creating fake users..."
num = 3
3.times do
  user = User.new(
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.last_name,
    username: Faker::Internet.unique.username,
    bio: Faker::Quote.famous_last_words,
    location: Faker::Address.city,
    email: "user#{num}@example.com",
    password: "123456"
  )
  num += 1
  user.avatar.attach(io: URI.open(Faker::Avatar.image), filename: "nes.png", content_type: "image/png")
  user.save!

  puts "Creating fake posts..."

  3.times do
    post = Post.new(
      title: Faker::TvShows::FamilyGuy.quote,
      description: Faker::TvShows::Friends.quote,
      location: Faker::Address.city,
      user: user
    )
      2.times do
        post.images.attach(io: URI.open(FakePicture::Blog.preview), filename: "nes.png", content_type: "image/png")
      end
    post.save!
  end
end

puts "Done"
