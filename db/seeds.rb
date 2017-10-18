require 'faker'

5.times do
  User.create!(
  email:    Faker::Internet.email,
  password: Faker::Lorem.characters(7)
  )
end

5.times do
  RegisteredApplication.create!(
  name: Faker::App.name,
  url: Faker::Internet.url,
  user: User.all.sample
  )
end

5.times do
  Event.create!(
  name: Faker::Name.unique.name,
  registered_application: RegisteredApplication.all.sample
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{RegisteredApplication.count} registered apps created"
puts "#{Event.count} events created"
