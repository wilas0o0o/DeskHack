require 'rails_helper'

RSpec.describe 'Hashtagモデルのテスト' do
  describe 'バリデーションのテスト' do
    let(:hashtag) { create(:hashtag) }
    let(:other_hashtag) { create(:hashtag) }

    context 'nameカラム' do
      it '空欄でないこと' do
        hashtag.name = ''
        expect(hashtag).to be_invalid
      end
      it '30文字以下であること: 30文字は〇' do
        hashtag.name = Faker::Lorem.characters(number: 30)
        expect(hashtag).to be_valid
      end
      it '30文字以下であること: 31文字は×' do
        hashtag.name = Faker::Lorem.characters(number: 31)
        expect(hashtag).to be_invalid
      end
      it '一意性があること' do
        hashtag.name = other_hashtag.name
        expect(hashtag).to be_invalid
      end
    end
  end
end
