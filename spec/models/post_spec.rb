require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let(:post_image) { create(:post_image) }
    let(:post) { build(:post, user_id: user.id) }

    context 'textカラム' do
      it '空欄でないこと' do
        post.text = ''
        expect(post).to be_invalid
      end
      it '200文字以下であること: 200文字は〇' do
        post.text = Faker::Lorem.characters(number: 200)
        expect(post).to be_valid
      end
      it '200文字以下であること: 201文字は×' do
        post.text = Faker::Lorem.characters(number: 201)
        expect(post).to be_invalid
      end
    end

    context 'situationカラム' do
      it '空欄でないこと' do
        post.situation = ''
        expect(post).to be_invalid
      end
    end
  end
end
