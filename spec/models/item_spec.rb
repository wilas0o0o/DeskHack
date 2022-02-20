require 'rails_helper'

RSpec.describe "Itemモデルのテスト", type: :model do
  describe 'バリデーションのテスト' do

    let(:user) { create(:user) }
    let(:post_image) { create(:post_image) }
    let(:post) { create(:post) }
    let(:category) { create(:category) }
    let!(:item) { build(:item, post_id: post.id, category_id: category.id) }

    context 'nameカラム' do
      it '空欄でないこと' do
        item.name = ''
        expect(item).to be_invalid
      end
      it '30文字以内であること: 30文字は〇' do
        item.name = Faker::Lorem.characters(number: 30)
        expect(item).to be_valid
      end
      it '30文字以内であること: 31文字は×' do
        item.name = Faker::Lorem.characters(number: 31)
        expect(item).to be_invalid
      end
    end

    context 'manufacturerカラム' do
      it '空欄でないこと' do
        item.manufacturer = ''
        expect(item).to be_invalid
      end
      it '30文字以内であること: 30文字は〇' do
        item.manufacturer = Faker::Lorem.characters(number: 30)
        expect(item).to be_valid
      end
      it '30文字以内であること: 31文字は×' do
        item.manufacturer = Faker::Lorem.characters(number: 31)
        expect(item).to be_invalid
      end
    end

    context 'category_idカラム' do
      it '空欄でないこと' do
        item.category_id = ''
        expect(item).to be_invalid
      end
    end
  end
end