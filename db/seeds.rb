require 'faker'

10.times do
  User.create(full_name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password)
end


