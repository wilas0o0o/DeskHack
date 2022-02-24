require 'rails_helper'

describe 'usersコントローラーのテスト' do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:original_post) { create(:post, user: user) }
  let!(:other_post) { create(:post, user: other_user) }

  before do
    visit new_user_session_path
    fill_in 'user[login]', with: user.username
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe '自分のユーザー詳細画面のテスト' do
    before do
      visit user_path(user)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/' + user.username
      end
      it 'ユーザー名が表示されている' do
        expect(page).to have_content user.name
      end
      it 'ユーザーIDが表示されている' do
        expect(page).to have_content user.username
      end
      it 'ユーザー編集リンクが表示されている' do
        expect(page).to have_link '編集', href: edit_user_path(user)
      end
      it '保存した投稿リンクが表示されている' do
        expect(page).to have_link '保存した投稿', href: bookmarked_user_path(user)
      end
      it '投稿一覧に自分の投稿が表示されている' do
        expect(page).to have_link '', href: post_path(original_post)
      end
    end
  end

  describe '他人のユーザー詳細画面のテスト' do
    before do
      visit user_path(other_user)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/' + other_user.username
      end
      it 'ユーザー名が表示されている' do
        expect(page).to have_content other_user.name
      end
      it 'ユーザーIDが表示されている' do
        expect(page).to have_content other_user.username
      end
      it 'ユーザー編集リンクが表示されていない' do
        expect(page).not_to have_link '編集', href: edit_user_path(other_user)
      end
      it '保存した投稿リンクが表示されていない' do
        expect(page).not_to have_link '保存した投稿', href: bookmarked_user_path(other_user)
      end
      it 'フォローするボタンが表示されている' do
        expect(page).to have_link 'フォローする', href: user_relationships_path(other_user)
      end
      it '投稿一覧に他人の投稿が表示されている' do
        expect(page).to have_link '', href: post_path(other_post)
      end
    end
  end

  describe 'ユーザー編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示内容の確認' do
      it 'avatarフォームが表示されている' do
        expect(page).to have_field 'user[avatar]'
      end
      it 'nameフォームが表示されている' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it 'usernameフォームが表示されている' do
        expect(page).to have_field 'user[username]', with: user.username
      end
      it 'emailフォームが表示されている' do
        expect(page).to have_field 'user[email]', with: user.email
      end
      it '"変更を保存"ボタンが表示されている' do
        expect(page).to have_button '変更を保存'
      end
    end

    context '登録成功のテスト' do
      avatar_path = Rails.root.join('spec/fixtures/test_avatar.png')
      before do
        @ex_user_name = user.name
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 5)
        attach_file('user[avatar]', avatar_path, make_visible: true)
        click_button '変更を保存'
      end

      it 'nameが正しく更新される' do
        expect(user.reload.name).not_to eq @ex_user_name
      end
      it 'avatarが正しく表示されている' do
        expect(page).to have_selector("img[src$='test_avatar.png']")
      end
      it 'リダイレクト先がユーザー詳細画面である' do
        expect(current_path).to eq '/' + user.username
        expect(user.reload.name).to have_content user.name
      end
    end
  end
end
