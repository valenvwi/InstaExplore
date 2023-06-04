# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Creating users..."
User.create(first_name: "Lai Fun", last_name: "Chu", username: "Laifunpig", bio: "Bababababaaa", location: "England", avatar: "https://media.istockphoto.com/id/1054801288/de/vektor/niedliche-schwein-l%C3%A4chelnd-cartoon-ikone-vektor-illustration.jpg?s=1024x1024&w=is&k=20&c=4-LRmqzvQMWOXoVqwWwpmdqsd03buTkIXu_cKnWRMxI=")
User.create(first_name: "Cris", last_name: "Baby", username: "iamyourbaby", bio: "Chill", location: "Zurich")
puts "Done"
