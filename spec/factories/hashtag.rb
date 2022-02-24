FactoryBot.define do
  factory :hashtag do
    name { Faker::Lorem.characters(number: 10) }
  end
end
