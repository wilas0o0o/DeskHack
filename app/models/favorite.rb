class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates_uniqueness_of :post_id, scope: :user_id

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
