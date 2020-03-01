# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Cleaning DB

puts 'Destroying all Events and Participants'
Event.destroy_all

puts 'Destroying all Users, Profiles and Participants again'
User.destroy_all # if Rails.env.development?

puts "Destroying Comments, Ratings, Followers and posts"
Comment.destroy_all # if Rails.env.development?
Rating.destroy_all # if Rails.env.development?
Follower.destroy_all # if Rails.env.development?
Post.destroy_all # if Rails.env.development?

puts "Destroying all instruments"
Instrument.destroy_all

#End Cleaning DB

# Creating users

puts "Creating custom development accounts"

['Nuno', 'Sofia', 'Nicolas'].each do |name|
  new_user = User.create!(
    first_name: "#{name}",
    email: "#{name}@gmail.com",
    password: '123456'
    )
puts "Creating custom test account for #{new_user.first_name} (email = #{new_user.email}, password = 123456 })"
print 'Creating random Users'
end
print ' { '
7.times do
  print '#'
  new_user = User.create!(
    first_name: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: '123456'
    )
end
print ' }'

# End creating users

puts ''

# Creating instruments

print 'Creating instruments'
print ' { '
arr = []
url = 'https://simple.wikipedia.org/wiki/List_of_musical_instruments'
document = Nokogiri::HTML.parse(open(url))
document.css('.mw-parser-output').each do |instrument_list|
  instruments = instrument_list.content.split(' ')
  instruments = instruments.drop(7)
  instruments.each do |instrument|
    print '#'
    Instrument.create(name: instrument)
  end
end
print ' }'

# End creating instruments
