require 'rails_helper'

RSpec.describe 'PostHashtagモデルのテスト' do
  describe 'バリデーションのテスト' do
    let(:post_hashtag) { create(:post_hashtag) }

    context '保存できる場合' do
      it 'post_idとhashtag_idを持っている' do
        expect(post_hashtag).to be_valid
      end
    end

    context '保存できない場合' do
      it 'post_idがnilである' do
        post_hashtag.post_id = nil
        expect(post_hashtag).to be_invalid
      end
      it 'hashtag_idがnilである' do
        post_hashtag.hashtag_id = nil
        expect(post_hashtag).to be_invalid
      end
    end
  end
end