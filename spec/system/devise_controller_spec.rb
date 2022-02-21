require 'rails_helper'

describe 'ログイン前のテスト' do
  describe 'Topページのテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'Sign upリンクが表示されている' do
        expect(page).to have_link 'Sign up', href: new_user_registration_path
      end
      it 'Sign inリンクが表示されている' do
        expect(page).to have_link 'Sign in', href: new_user_session_path
      end
      it 'how_to_useが表示されている 'do
        expect(page).to have_content 'DeskHackで出来ること'
      end
      it 'aboutが表示されている' do
        expect(page).to have_content 'DeskHackとは'
      end
    end
  end

  describe 'ユーザー新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認 'do
      it 'URLが正しい' do
        expect(current_path).to eq '/sign_up'
      end
      it '新規登録ボタンが表示されている 'do
        expect(page).to have_button '新規登録'
      end
      it 'nameフォームが表示されている' do
        expect(page).to have_field 'user[name]'
      end
      it 'usernameフォームが表示されている' do
        expect(page).to have_field 'user[username]'
      end
      it 'emailフォームが表示されている' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示されている' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示されている' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it 'ログインリンクが表示されている' do
        expect(page).to have_link 'こちら', href: new_user_session_path
      end
    end

    context '登録成功のテスト '  do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'user[username]', with: Faker::Lorem.characters(number: 5)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '正しく登録される' do
        expect { click_button '新規登録' }.to change(User.all, :count).by(1)
      end
      it 'リダイレクト先が投稿一覧画面である' do
        click_button '新規登録'
        expect(current_path).to eq '/posts'
      end
    end

    context '登録失敗のテスト '  do
      before do
        fill_in 'user[name]', with: ''
        fill_in 'user[username]', with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button '新規登録'
      end

      it '登録に失敗し新規登録画面に戻る' do
        expect(current_path).to eq '/sign_up'
      end
    end
  end

  describe 'ユーザーログインのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/sign_in'
      end
      it 'ログインボタンが表示されている' do
        expect(page).to have_button 'ログイン'
      end
      it 'loginフォームが表示されている 'do
        expect(page).to have_field 'user[login]'
      end
      it 'passwordフォームが表示されている' do
        expect(page).to have_field 'user[password]'
      end
      it '新規登録リンクが表示されている' do
        expect(page).to have_link 'こちら', href: new_user_registration_path
      end
    end

    context 'ログイン成功のテスト' do
      before  do
        fill_in 'user[login]', with: user.username
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end

      it 'リダイレクト先が投稿一覧画面である' do
        expect(current_path).to eq '/posts'
      end
    end

    context 'ログイン失敗のテスト' do
      before  do
        fill_in 'user[login]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗しログイン画面に戻る' do
        expect(current_path).to eq '/sign_in'
      end
    end
  end
end

describe 'ユーザーログイン後のテスト 'do
  let(:user) { create(:user) }

  before  do
    visit new_user_session_path
    fill_in 'user[login]', with: user.username
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  context '表示内容の確認' do
    it 'URLのテスト' do
      expect(current_path).to eq '/posts'
    end
    it '検索窓が表示されている' do
      expect(page).to have_field 'content'
    end
    it '投稿詳細リンクが表示されている' do
      posts_link = find('.fa-home')
      expect(posts_link[:href]).to eq posts_path
    end
    it '新規投稿リンクが表示されている' do
      new_post_link = find('.fa-plus-square')
      expect(new_post_link[:href]).to eq new_post_path
    end
    it 'マイページリンクが表示されている' do
      expect(page).to have_link 'マイページ', href: user_path(user)
    end
    it 'ログアウトリンクが表示されている' do
      expect(page).to have_link 'ログアウト', href: destroy_user_session_path
    end
  end

  context 'ユーザーログアウトのテスト' do
    before do
      click_link 'ログアウト'
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている: Sign_inリンクが表示されている' do
        expect(page).to have_link 'Sign in', href: new_user_session_path
      end
      it 'リダイレクト先がTopである' do
        expect(current_path).to eq '/'
      end
    end
  end
end