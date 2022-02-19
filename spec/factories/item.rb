FactoryBot.define do
  factory :item do
    name { Faker::Lorem.characters(number: 10) }
    manufacturer { Faker::Lorem.characters(number: 10) }
    post
  end
end
