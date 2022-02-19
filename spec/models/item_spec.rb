# froxen_string_literal: true

require 'rails_helper'

RSpec.describe "Itemモデルのテスト", type: :model do
  describe 'バリデーションのテスト' do
    subject { item.valid? }

    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let(:category) { create(:category) }
    let!(:item) { build(:item, post_id: post.id, item_id: item.id) }

    context 'nameカラム' do
      it '空欄でないこと' do
        item.name = ''
        is_expected.to eq false
      end
      it '30文字以内であること: 30文字は〇' do
        item.name = Faker::Lorem.characters(number: 30)
        is_expected.to eq true
      end
      it '30文字以内であること: 31文字は×' do
        item.name = Faker::Lorem.characters(number: 31)
        is_expected.to eq false
      end
    end

    context 'manufacturerカラム' do
      it '空欄でないこと' do
        item.manufacturer = ''
        is_expected.to eq false
      end
      it '30文字以内であること: 30文字は〇' do
        item.manufacturer = Faker::Lorem.characters(number: 30)
        is_expected.to eq true
      end
      it '30文字以内であること: 31文字は×' do
        item.manufacturer = Faker::Lorem.characters(number: 31)
        is_expected.to eq false
      end
    end

    context 'category_idカラム' do
      it '空欄でないこと' do
        item.category_id = ''
        is_expected.to eq false
      end
    end
  end
end