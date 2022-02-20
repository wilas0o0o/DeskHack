require 'rails_helper'

RSpec.describe 'Relationshipモデルのテスト' do
  
  let(:relationship) { create(:relationship) }

  describe '保存のテスト' do
    context '保存できる場合' do
      it 'すべて揃っていると保存できる' do
        expect(relationship).to be_valid
      end
    end

    context '保存できない場合' do
      it 'follower_idがない場合は保存できない' do
        relationship.follower_id = nil
        expect(relationship).to be_invalid
      end

      it 'followed_idがない場合は保存できない' do
        relationship.followed_id = nil
        relationship.valid?
        expect(relationship).to be_invalid
      end
    end

    context '一意性のテスト' do
      let(:other_user) { create (:relationship) }

      it 'follower_idとfollowed_idは一意である' do
        other_relationship = FactoryBot.build(:relationship, follower_id: relationship.follower_id, followed_id: relationship.followed.id)
        expect(other_relationship).to be_invalid
      end

      it 'follower_idが同じでもfollowed_idが違えば保存できる' do
        other_relationship = FactoryBot.build(:relationship, follower_id: relationship.follower_id, followed_id: other_user.followed_id)
        expect(other_relationship).to be_valid
      end

      it 'followed_idが同じでもfollower_idが違えば保存できる' do
        other_relationship = FactoryBot.build(:relationship, follower_id: other_user.follower_id, followed_id: relationship.followed_id)
        expect(other_relationship).to be_valid
      end
    end
  end
end