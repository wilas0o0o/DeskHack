FactoryBot.define do
  factory :post do
    text { Faker::Lorem.characters(number:20) }
    caption { '#test' }
    situation { 'Gaming' }
    user
  end
end
