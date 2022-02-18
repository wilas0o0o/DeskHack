# froxen_string_literal: true

require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }

    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }

    context 'textカラム' do
      it '空欄でないこと' do
        post.text = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 200文字は〇' do
        post.text = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字は×' do
        post.text = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end

    # context 'post_imagesカラム' do
    #   it '空欄でないこと' do
    #     post.post_images = ''
    #     is_expected.to eq false
    #   end
    # end

    context 'situationカラム' do
      it '空欄でないこと' do
        post.situation = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'PostImageモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:post_images).macro).to eq :has_many
      end
    end
    context 'Itemモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:items).macro).to eq :has_many
      end
    end
    context 'Faviriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context 'PostCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:post_comments).macro).to eq :has_many
      end
    end
    context 'Bookmarkモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:bookmarks).macro).to eq :has_many
      end
    end
    context 'PostTagモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:post_tags).macro).to eq :has_many
      end
    end
  end
end