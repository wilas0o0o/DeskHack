require 'rails_helper'

RSpec.describe "Userモデルのテスト", type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '20文字以下であること: 20文字は〇' do
        user.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'usernameカラム' do
      it '空欄でないこと' do
        user.username = ''
        is_expected.to eq false
      end
      it '5文字以上であること: 4文字は×' do
        user.username = Faker::Lorem.characters(number: 4)
        is_expected.to eq false
      end
      it '5文字以上であること: 5文字は〇' do
        user.username = Faker::Lorem.characters(number: 5)
        is_expected.to eq true
      end
      it '15文字以下であること: 15文字は〇' do
        user.username = Faker::Lorem.characters(number: 15)
        is_expected.to eq true
      end
      it '15文字以下であること: 16文字は×' do
        user.username = Faker::Lorem.characters(number: 16)
        is_expected.to eq false
      end
      it '一意性があること' do
        user.username = other_user.username
        is_expected.to eq  false
      end
      it '半角英数字であること: fff000は〇' do
        user.username = "fff000"
        is_expected.to eq  true
      end
      it '半角英数字であること: ユーザー名は×' do
        user.username = "ユーザー名"
        is_expected.to eq  false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nになっている' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
    # context 'Faviriteモデルとの関係' do
    #   it '1:Nとなっている' do
    #     expect(User.reflect_on_association(:favorites).macro).to eq :has_many
    #   end
    # end
    # context 'PostCommentモデルとの関係' do
    #   it '1:Nとなっている' do
    #     expect(User.reflect_on_association(:post_comments).macro).to eq :has_many
    #   end
    # end
    # context 'Bookmarkモデルとの関係' do
    #   it '1:Nとなっている' do
    #     expect(User.reflect_on_association(:bookmarks).macro).to eq :has_many
    #   end
    # end
    # context 'Notificationモデルとの関係' do
    #   it '1:Nとなっている' do
    #     expect(User.reflect_on_association(:notifications).macro).to eq :has_many
    #   end
    # end
    # context 'Relationshipsモデルとの関係' do
    #   it '1:Nとなっている' do
    #     expect(User.reflect_on_association(:relationships).macro).to eq :has_many
    #   end
    # end
  end
end