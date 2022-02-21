require 'rails_helper'

describe 'relationshipsコントローラーのテスト' do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user[login]', with: user.username
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    visit user_path(other_user)
  end

  describe 'フォロー機能のテスト' do
    context 'ユーザーをフォローできる' do
      it '自分のfollowingsが増える' do
        expect { click_link 'フォローする' }.to change(user.followings, :count).by(1)
      end
      it '相手のfollowersが増える' do
        expect { click_link 'フォローする' }.to change(other_user.followers, :count).by(1)
      end
      it 'ボタンの表記が"フォロー中"に変わる' do
        click_link 'フォローする'
        expect(page).to have_link 'フォロー中', href: user_relationships_path(other_user)
      end
    end
  end

  describe 'フォロー解除機能のテスト' do
    before do
      click_link 'フォローする'
      click_link 'フォロー中', href: user_relationships_path(other_user)
    end

    context 'ユーザーをフォロー解除できる' do
      it '自分のfollowingsが減る' do
        expect(Relationship.where(follower_id: user.id).count).to eq 0
      end
      it '相手のfollowersが減る' do
        expect(Relationship.where(followed_id: user.id).count).to eq 0
      end
      it 'ボタンの表記がフォローするに変わる' do
        expect(page).to have_link 'フォローする', href: user_relationships_path(other_user)
      end
    end
  end
end
