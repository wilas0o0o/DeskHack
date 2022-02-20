require 'rails_helper'

RSpec.describe "Userモデルのテスト", type: :model do
  describe 'バリデーションのテスト' do

    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        expect(user).to be_invalid
      end
      it '20文字以下であること: 20文字は〇' do
        user.name = Faker::Lorem.characters(number: 20)
        expect(user).to be_valid
      end
      it '20文字以下であること: 21文字は×' do
        user.name = Faker::Lorem.characters(number: 21)
        expect(user).to be_invalid
      end
    end

    context 'usernameカラム' do
      let(:other_user) { create(:user) }
      
      it '空欄でないこと' do
        user.username = ''
        expect(user).to be_invalid
      end
      it '5文字以上であること: 4文字は×' do
        user.username = Faker::Lorem.characters(number: 4)
        expect(user).to be_invalid
      end
      it '5文字以上であること: 5文字は〇' do
        user.username = Faker::Lorem.characters(number: 5)
        expect(user).to be_valid
      end
      it '15文字以下であること: 15文字は〇' do
        user.username = Faker::Lorem.characters(number: 15)
        expect(user).to be_valid
      end
      it '15文字以下であること: 16文字は×' do
        user.username = Faker::Lorem.characters(number: 16)
        expect(user).to be_invalid
      end
      it '一意性があること' do
        user.username = other_user.username
        expect(user).to be_invalid
      end
      it '半角英数字であること: fff000は〇' do
        user.username = "fff000"
        expect(user).to be_valid
      end
      it '半角英数字であること: ユーザー名は×' do
        user.username = "ユーザー名"
        expect(user).to be_invalid
      end
    end
  end
end