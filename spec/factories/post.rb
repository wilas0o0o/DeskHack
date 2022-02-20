FactoryBot.define do
  factory :post do
    text { Faker::Lorem.characters(number: 20) }
    caption { '#test' }
    situation { 'Gaming' }
    user
    post_images do
      [
        PostImage.new(
          image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg'))
        ),
      ]
    end
  end
end
