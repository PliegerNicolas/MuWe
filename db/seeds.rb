# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require "open-uri"


# Cleaning DB

puts 'Destroying all Events and Participants'
Event.destroy_all

puts "Destroying Comments, Ratings, Followers and posts"
Comment.destroy_all # if Rails.env.development?
Rating.destroy_all # if Rails.env.development?
Follower.destroy_all # if Rails.env.development?
Post.destroy_all # if Rails.env.development?

puts 'Destroying all Users, Profiles and Participants again'
User.destroy_all # if Rails.env.development?

puts "Destroying all instruments"
Instrument.destroy_all

puts "Destroying all music styles"
MusicStyle.destroy_all

#End Cleaning DB

# Creating users

puts "Creating custom development accounts"
photos_array = ['https://avatars3.githubusercontent.com/u/6062926?v=4', 'https://media-exp1.licdn.com/dms/image/C4D03AQEmothdoW13iA/profile-displayphoto-shrink_800_800/0?e=1590624000&v=beta&t=wwftHdc-adZ-BbtZj1U0GY0BUn8ZF8Xhk9Rg8gTnEP8','https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1571484812/vd06m1xkrasx7aqbzdjs.jpg']
i = 0
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
  new_user.profile.profile_photo.attach(io: URI.open(photos_array[i]), filename: "photo#{i}.png", content_type: 'image/png')
  new_user.profile.save
  i = i + 1
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
puts 'Creating user instruments conection'
print ' { '
 User.all.each do |user|
  InstrumentUser.new(user_id: user.id, instrument_id: Instrument.all.sample.id).save
  print '#'
 end
print ' }'


puts ''

# Creating music styles

print 'Creating music styles'
print ' { '
MusicStyle.create(style: 'Unknown')
print '#'
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
16.times do
  start_time = Faker::Time.between(from: Time.now + 6.hours - 5.minutes, to: Time.now + 18.hours)
  new_event = Event.create(
    user_id: [User.first, User.second, User.third].sample.id,
    title: Faker::BossaNova.song,
    country: Faker::Address.country,
    city: Faker::Address.city,
    address: Faker::Address.street_name,
    description: Faker::Lorem.sentence(word_count: 12),
    max_players: Faker::Number.within(range: 2..8),
    music_style_id: MusicStyle.order('RANDOM()').first.id,
    status: Faker::Number.within(range: 0..2),
    start_date: Faker::Date.between(from: 2.days.ago, to: Date.today + 10),
    start_time: start_time,
    end_time: Faker::Time.between(from: start_time, to: start_time + 2.hours)
  )
  print '#'
end

def rand_coords(coords, lat, lng, num = 5)
  num.times do
    coords << { lat: lat + Random.rand(0.01..0.05), lng: lng + Random.rand(0.01..0.05) }
  end
end

coords = Array.new
# Add events near Sofia usual position
# Oeiras - main one
lat = 38.691650
lng = -9.3106365
coords << { lat: lat, lng: lng }
rand_coords(coords, lat, lng)

# Add events near Nicolas usual position
# Azoia - main one
lat = 38.771137
lng = -9.4770421
coords << { lat: lat, lng: lng }
rand_coords(coords, lat, lng)

# Add events near Nuno usual position
# Qta do Anjo - main one
lat = 38.567527
lng = -8.899005
coords << { lat: lat, lng: lng }
rand_coords(coords, lat, lng)

# insert a bunch of random coords
rand_coords(coords, 38.898212, -9.257787, 10)
rand_coords(coords, 38.824677, -9.160750, 10)
rand_coords(coords, 38.73542, -9.142147, 10)
rand_coords(coords, 40.209668, -8.41986, 20)
rand_coords(coords, 40.660841, -7.908266, 15)
rand_coords(coords, 41.145657, -8.616749, 15)

coords.size.times do |i|
  start_time = Faker::Time.between(from: Time.now - 5.minutes, to: Time.now + 4.hours)
  Event.create!(
    user_id: User.order('RANDOM()').first.id,
    title: Faker::Music.album,
    country: 'Portugal',
    latitude: coords[i][:lat],
    longitude: coords[i][:lng],
    description: Faker::Lorem.sentence(word_count: 18),
    max_players: Faker::Number.within(range: 2..8),
    music_style_id: MusicStyle.order('RANDOM()').first.id,
    status: Faker::Number.within(range: 0..2),
    start_date: Faker::Date.between(from: 2.days.ago, to: Date.today + 7),
    start_time: start_time,
    end_time: Faker::Time.between(from: start_time, to: start_time + 2.hours)
  )
  print '#'
end


print ' }'

#End creating events
