# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).



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

[['Nuno', 'Martins'], ['Sofia', 'Mogas'], ['Nicolas', 'Plieger']].each do |name|
  new_user = User.create!(
    first_name: "#{name[0]}",
    email: "#{name[0]}@gmail.com",
    password: '123456'
  )
  puts "Creating custom test account for #{new_user.first_name} (email = #{new_user.email}, password = 123456 )"
  puts "Setting up custom test account profile"
  new_user.profile.last_name = name[1]
  new_user.profile.birth_date = Faker::Date.birthday(min_age: 18, max_age: 65)
  new_user.profile.bio = Faker::Lorem.sentence(word_count: 18)
  new_user.profile.city = Faker::Address.city
  new_user.profile.save
end

print 'Creating random Users'

print ' { '
7.times do
  print '#'
  new_user = User.create!(
    first_name: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: '123456'
  )
  new_user.profile.last_name = Faker::Name.last_name
  new_user.profile.birth_date = Faker::Date.birthday(min_age: 18, max_age: 65)
  new_user.profile.bio = Faker::Lorem.sentence(word_count: 18)
  new_user.profile.city = Faker::Address.city
  new_user.profile.save
end
print ' }'

# End creating users

puts ''

# Creating instruments

print 'Creating instruments'
print ' { '
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

puts ''

# Creating music styles

print 'Creating music styles'
print ' { '
url = 'https://en.wikipedia.org/wiki/List_of_popular_music_genres'
document = Nokogiri::HTML.parse(open(url))
arr = []
document.css('.mw-headline').each do |content|
  arr << content.text
end
arr = arr.drop(7)
arr.pop(3)
arr.each do |music_style|
  MusicStyle.create(style: music_style)
  print '#'
end
print ' }'

# End creating music styles

puts ''

# Creating Events

print 'Creating events'
print ' { '
15.times do
  Event.create(
    user_id: User.order('RANDOM()').first.id,
    title: Faker::BossaNova.song,
    address: Faker::Address.country,
    description: Faker::Lorem.sentence(word_count: 18),
    max_players: Faker::Number.within(range: 2..8),
    music_style_id: MusicStyle.order('RANDOM()').first.id,
    status: Faker::Number.within(range: 0..2),
    start_date: Faker::Date.between_except(from: 15.days.ago, to: Date.today, excepted: Date.today),
    start_time: Faker::Time.between(from: Time.now - 1, to: Time.now),
    duration: Faker::Time.between(from: Time.now, to: Time.now + 8)
  )
  print '#'
end

print ' }'

#End creating events
