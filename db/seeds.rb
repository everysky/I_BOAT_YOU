# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require "faker"

puts "Starting..."

if User.all.size == 0
  2.times do
    pw = "password"
    email = Faker::Internet.email
    user = User.create!(email: email, password: pw, password_confirmation: pw )
    p user
  end
end

1.times do
  file = URI.open('http://loremflickr.com/800/600/boat')
  boat = Boat.create!(name: Faker::Hipster.word, address: ["Pl. de la Navigation 3, 1006 Lausanne", "Bouveret1897 Port-Valais", "Quai Perdonnet 19, 1800 Vevey", "Quai de Cologny 1, 1223 Cologny"].sample, price: (1..100).to_a.sample, description: Faker::Lorem.paragraph, user: User.all.sample, size: (1..17).to_a.sample, hp: (50..200).to_a.sample, capacity: (2..12).to_a.sample)
  boat.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  p boat
  sleep 5
end
puts "Ended!"
