require 'rails_helper'

RSpec.describe 'Notificationモデルのテスト', type: :model do
  describe '保存のテスト' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    context 'Postに対する通知のテスト' do
      let(:original_post) { create(:post) }
      let(:favorite) { create(:favorite) }
      let(:post_comment) { create(:post_comment) }

      it 'いいねがついた時に保存できる' do
        notification = FactoryBot.create(
          :notification,
          visitor_id: user.id,
          visited_id: other_user.id,
          post_id: original_post.id,
          action: 'favorite'
        )
        expect(notification).to be_valid
      end

      it 'コメントがついた時に保存できる' do
        notification = FactoryBot.create(
          :notification,
          visitor_id: user.id,
          visited_id: other_user.id,
          post_id: original_post.id,
          post_comment_id: post_comment.id,
          action: 'comment'
        )
        p notification
        expect(notification).to be_valid
      end
    end

    context 'フォロー関連の通知のテスト' do
      it 'フォローされた時に保存できる' do
        notification = FactoryBot.create(
          :notification,
          visitor_id: user.id,
          visited_id: other_user.id,
          action: 'follow'
        )
        expect(notification).to be_valid
      end
    end
  end
end
