# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Destroying all Events and Participants'
Event.destroy_all

puts 'Destroying all Users, Profiles and Participants again'
User.destroy_all

puts "Destroying Comments, Ratings, Followers and posts"
Comment.destroy_all
Rating.destroy_all
Follower.destroy_all
Post.destroy_all

print 'Creating Users'
10.times do
  new_user = User.create!(
    email: Faker::Internet.email
    password: '123456'

    )
end
