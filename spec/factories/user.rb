FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 5) }
    username { Faker::Lorem.characters(number: 5) }
    email { Faker::Internet.email }
    password { 'password' }
    encrypted_password { 'password' }
  end
end
