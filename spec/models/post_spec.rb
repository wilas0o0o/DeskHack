require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let(:original_post) { build(:post, user_id: user.id) }

    context 'textカラム' do
      it '空欄でないこと' do
        original_post.text = ''
        expect(original_post).to be_invalid
      end
      it '200文字以下であること: 200文字は〇' do
        original_post.text = Faker::Lorem.characters(number: 200)
        expect(original_post).to be_valid
      end
      it '200文字以下であること: 201文字は×' do
        original_post.text = Faker::Lorem.characters(number: 201)
        expect(original_post).to be_invalid
      end
    end

    context 'situationカラム' do
      it '空欄でないこと' do
        original_post.situation = ''
        expect(original_post).to be_invalid
      end
    end
  end
end
