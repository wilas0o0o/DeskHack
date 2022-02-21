require 'rails_helper'

describe 'usersコントローラーのテスト' do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:post_images) { create(:post_images) }
  let(:post) { create(:post, user: user) }
  let(:other_post) { create(:post, user: other_user) }
  
  describe 'ユーザー詳細画面のテスト' do
    
end