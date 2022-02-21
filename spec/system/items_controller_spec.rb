require 'rails_helper'

describe 'itemsコントローラーのテスト' do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:post_images) { create(:post_images) }
  let(:post) { create(:post, user: user) }

  before do
    visit new_user_session_path
    fill_in 'user[login]', with: user.username
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    visit post_path(post)
  end

  describe 'アイテム追加のテスト' do
    context '投稿成功のテスト' do
      before do
        fill_in 'item[name]', with: Faker::Lorem.characters(number: 10)
        select 'デスク', from: 'item[category_id]'
        fill_in 'item[manufacturer', with: Faker::Lorem.characters(number: 10)
      end

      it '投稿が正しく保存される' do
        expect { click_button '追加する' }.to change(post.items, :count).by(1)
      end
    end
  end
end