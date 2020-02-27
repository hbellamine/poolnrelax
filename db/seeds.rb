# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'


puts 'Destroying all puppies...'
Puppy.destroy_all
puts 'Seeding fresh new puppies!'

User.create!(email: 'abc@gmail.com', password: 'password')

url = "https://dog.ceo/api/breed/hound/images"
open_url = open(url).read
json_url = JSON.parse(open_url)
photos_library = json_url["message"]

5.times do

name = Faker::Creature::Dog.name
age = rand(1..10)
breed = Faker::Creature::Dog.breed
price = rand(20..50)
location = Faker::Address.street_address
photo = photos_library.sample
p photo

Puppy.create!(name: name, age: age, breed: breed, price: price, user_id: 1, location: location, picture: photo)
end
