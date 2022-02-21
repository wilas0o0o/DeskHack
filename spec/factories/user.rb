FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 5) }
    username { Faker::Lorem.characters(number: 5) }
    email { Faker::Internet.email }
    # avatar { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_avatar.png')) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
