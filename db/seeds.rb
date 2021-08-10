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
users = []
5.times do
  pw = Faker::Internet.password
  user = User.create!(email: Faker::Internet.email, password: pw, password_confirmation: pw )
  users << user
  puts user
end

10.times do
  file = URI.open('https://source.unsplash.com/random')
  boat = Boat.create!(name: Faker::Hipster.word, location: Faker::Address.full_address, description: Faker::Lorem.paragraph, user_id: users.sample.id)
  boat.photo.attach(io: file, filename: Faker::Lorem.word, content_type: 'image/png')
  puts boat
end
puts "Ended!"