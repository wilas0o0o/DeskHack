class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # belongs_to :parent, class_name: 'Comment', optional: true
  # has_many   :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
  has_many   :notifications, dependent: :destroy

  validates :comment, presence: true, length: { maximum: 140 }
end
