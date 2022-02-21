require 'rails_helper'

describe 'notificationsコントローラーのテスト' do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user[login]', with: user.username
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  context 'フォローした時のテスト' do
    before do
      visit user_path(other_user)
      click_link 'フォローする'
    end

    it '通知が正しく保存される' do
      expect(
        Notification.where(visitor_id: user.id, visited_id: other_user.id, action: 'follow').count
      ).to eq 1
    end
  end
end
