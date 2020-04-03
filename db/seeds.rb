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
[['Nuno', 'Martins', 'Palmela'], ['Sofia', 'Mogas', 'Oeiras'], ['Nicolas', 'Plieger', 'Colares']].each do |name|
  new_user = User.create!(
    first_name: "#{name[0]}",
    email: "#{name[0]}@gmail.com",
    password: '123456'
  )
  puts "Creating custom test account for #{new_user.first_name} (email = #{new_user.email}, password = 123456 )"
  puts "Setting up custom test account profile"
  new_user.profile.last_name = name[1]
  new_user.profile.birth_date = Faker::Date.birthday(min_age: 18, max_age: 65)
  new_user.profile.bio = i == 1 ? "I play guitar for more than 2 years and now I am expanding my knowledge and started to learn accordion!! If you play accordion join my events!! Let's jam together!" : Faker::Lorem.sentence(word_count: 18)
  new_user.profile.city = name[2]
  new_user.profile.profile_photo.attach(io: URI.open(photos_array[i]), filename: "photo#{i}.png", content_type: 'image/png')
  new_user.profile.save
  i = i + 1
end

print 'Creating random Users'

cities = [ 'Lisboa', 'Porto', 'Coimbra', 'Faro', 'Aveiro', 'Braga', 'Viana do Castelo', 'Oeiras', 'Loures', 'Odivelas', 'Seixal', 'Almada', 'Setúbal', 'Leiria', 'Castelo Branco', 'Viseu' ]


bios = [
  "Coffee fan. Twitter aficionado. Infuriatingly humble communicator. Avid social media advocate.",
  "Incurable internet junkie. Devoted writer. Award-winning troublemaker. Passionate reader.",
  "Hipster-friendly zombie scholar. Total coffee expert. Extreme bacon junkie. Travel guru.",
  "Organizer. Communicator. Infuriatingly humble explorer. Twitter fanatic. Web specialist. General tv guru. Zombie practitioner.",
  "Zombie maven. Food lover. Passionate twitteraholic. Infuriatingly humble internet enthusiast.",
  "Amateur analyst. Web fanatic. Certified pop culture fan. Total alcohol expert. Travel guru. Incurable social media lover.",
  "Creator. Freelance coffee practitioner. Explorer. Tv fanatic. Music lover. Student. Pop culture trailblazer. Typical web aficionado.",
  "Organizer. Freelance introvert. Reader. Internet scholar. Communicator. Alcohol specialist.",
  "Typical social media guru. Coffee aficionado. Infuriatingly humble beer practitioner.",
  "Writer. Freelance analyst. Internet junkie. Web ninja. Prone to fits of apathy. Zombie advocate.",
  "Incurable zombie junkie. Certified alcohol expert. Writer. Infuriatingly humble social media guru. Reader.",
  "Alcohol scholar. Student. Coffee nerd. Certified thinker. Communicator. Tv ninja. Organizer. Passionate troublemaker. General reader.",
  "Avid twitter specialist. Amateur introvert. Beer enthusiast. Evil coffee practitioner. Web fanatic. Lifelong explorer.",
  "Typical explorer. Infuriatingly humble reader. Alcohol specialist. General zombie practitioner.",
  "General web scholar. Writer. Passionate travelaholic. Entrepreneur. Organizer. Bacon nerd. Incurable twitter expert.",
  "Web maven. Social media fanatic. Twitter advocate. Reader. Passionate travel guru. Student. Alcohol nerd.",
  "Extreme social media buff. Typical reader. Zombie evangelist. Friendly entrepreneur. Future teen idol. Avid travel enthusiast.",
  "Devoted tv ninja. Entrepreneur. Internet lover. Friendly food nerd. Beer trailblazer. Problem solver. Bacon aficionado.",
  "Award-winning alcohol evangelist. Passionate explorer. Evil music ninja. Introvert. Devoted twitter guru. Hardcore analyst.",
  "Incurable music nerd. Certified creator. Tv fanatic. Food trailblazer. Infuriatingly humble coffee geek.",
  "Beeraholic. Prone to fits of apathy. Twitter junkie. Coffee fan. Amateur organizer. Incurable music guru. Internet nerd. Evil thinker.",
  "Wannabe pop culture specialist. Tv scholar. Lifelong social media practitioner. Music geek. Falls down a lot.",
  "Lifelong twitter fan. Alcohol guru. Amateur zombie buff. Extreme travel junkie.",
  "Extreme beer lover. Food aficionado. Explorer. Incurable troublemaker. Web advocate.",
  "Professional entrepreneur. Alcohol scholar. Unable to type with boxing gloves on. Evil explorer. Pop culture practitioner. General twitter guru. Tvaholic."
]



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
  new_user.profile.bio = bios[Random.rand(0..bios.count)]
  new_user.profile.city = cities[Random.rand(0..cities.count)]
  new_user.profile.save
end
print ' }'

# End creating users

puts ''

# Creating instruments

print 'Creating instruments'
print ' { '
instruments = [
  'Accordion','Bagpipes','Banjo','Bluegrass banjo','Bass guitar','Bassoon','Berimbau','Bongo','Chimta','Cello','Clarinet','Clavichord','Cornet','Cymbal','Didgeridoo','Double bass',
  'Drum kit','Euphonium','Fiddle','Flute','French horn','Glockenspiel','Guitar','Acoustic guitar','Bass guitar','Classical guitar','Electric guitar','Harmonica','Harp','Harpsichord','Hammered dulcimer',
  'Kalimba','Lute','Lyre','Mandolin','Marimba','Oboe','Ocarina','Organ','Pan Pipes','Piano','Piccolo','Recorder','Saxophone','Sing','Sitar','Steelpan','Synthesizer','Tambourine','Timpani',
  'Triangle','Trombone','Trumpet','Tuba','Ukulele','Viola','Violin','Cello (violoncello)','Vocal','Xylophone'
]
instruments.each do |instrument|
  print '#'
  Instrument.create(name: instrument)
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

event_addresses = [
  ["38.7062666","-9.1562786","Avenida 24 de Julho","Lisboa"],
  ["38.7056923","-9.1470167","Rua da Cintura do Porto de Lisboa","Lisboa"],
  ["38.8026128","-9.1885833","Rua Alves da Cunha","Lisboa"],
  ["38.7096896","-9.146244","Rua da Bica de Duarte Belo","Lisboa"],
  ["38.6968871","-9.2022974","Rua Vieira Portuense","Lisboa"],
  ["38.7134916","-9.1417979","Calçada do Duque","Lisboa"],
  ["38.7860037","-9.324426","Rua do Vale","Lisboa"],
  ["38.7145248","-9.1243206","Travessa do Paraíso","Lisboa"],
  ["38.7145248","-9.1243206","Rua do Sacramento à Lapa","Lisboa"],
  ["38.7166622","-9.1385516","Calçada de Santana","Lisboa"],
  ["38.6974806","-9.3007819","Alameda dos Poetas","Oeiras"],
  ["38.7121126","-9.2362418","Avenida Carolina Michaelis","Oeiras"],
  ["38.6878003","-9.3143196","Avenida do Brasil","Oeiras"],
  ["38.7039773","-9.299173","Largo Alto do Mocho","Oeiras"]
]

# Creating Events
print 'Creating events'

# Creating events around Lisbon and Oeiras
# belonging to Nicolas and Nuno

event_addresses.each do |a|
  start_time = Faker::Time.between(from: Time.now + 6.hours - 5.minutes, to: Time.now + 18.hours)
  new_event = Event.create(
    user_id: [User.first, User.third].sample.id,
    title: Faker::Music.album,
    country: "Portugal",
    city: a[3],
    longitude: a[0],
    latitude: a[1],
    address: a[2],
    description: Faker::Hipster.sentence(word_count: 12),
    max_players: Faker::Number.within(range: 2..8),
    music_style_id: MusicStyle.order('RANDOM()').first.id,
    status: Faker::Number.within(range: 0..2),
    start_date: Faker::Date.between(from: Date.today, to: Date.today + 2),
    start_time: start_time,
    end_time: Faker::Time.between(from: start_time, to: start_time + 2.hours)
  )
end

def rand_coords(coords, lat, lng, num = 5)
  num.times do
    coords << { lat: lat + Random.rand(0.01..0.05), lng: lng + Random.rand(0.01..0.05) }
  end
end

coords = Array.new
# # Add events near Sofia usual position
# # Oeiras - main one
lat = 38.691650
lng = -9.3106365
coords << { lat: lat, lng: lng }
rand_coords(coords, lat, lng)

# # Add events near Nicolas usual position
# # Azoia - main one
lat = 38.771137
lng = -9.4770421
coords << { lat: lat, lng: lng }
rand_coords(coords, lat, lng)

# # Add events near Nuno usual position
# # Qta do Anjo - main one
lat = 38.567527
lng = -8.899005
coords << { lat: lat, lng: lng }
rand_coords(coords, lat, lng)

# # insert a bunch of random coords
rand_coords(coords, 38.898212, -9.257787, 10)
rand_coords(coords, 38.824677, -9.160750, 10)
rand_coords(coords, 38.73542, -9.142147, 10)
rand_coords(coords, 40.209668, -8.41986, 20)
rand_coords(coords, 40.660841, -7.908266, 15)
rand_coords(coords, 41.145657, -8.616749, 15)

coords.size.times do |i|
  start_time = Faker::Time.between(from: Time.now - 5.minutes, to: Time.now + 4.hours)
  res = Geocoder.search([coords[i][:lat], coords[i][:lng]])
  city = res.first.county
  address = res.first.display_name.split(',')
  Event.create!(
    user_id: User.order('RANDOM()').first.id,
    title: Faker::Music.album,
    country: 'Portugal',
    city: city,
    address: address[0],
    latitude: coords[i][:lat],
    longitude: coords[i][:lng],
    description: Faker::Lorem.sentence(word_count: 18),
    max_players: Faker::Number.within(range: 2..8),
    music_style_id: MusicStyle.order('RANDOM()').first.id,
    status: Faker::Number.within(range: 0..2),
    start_date: Faker::Date.between(from: 2.days.ago, to: Date.today + 7),
    start_time: start_time,
    end_time: Faker::Time.between(from: start_time, to: start_time + Random.rand(1...8).hours)
  )
  print '#'
end


print ' }'

#End creating events
