class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_images, dependent: :destroy
  has_one  :post_image, -> {order(:id).limit(1)}, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :items, dependent: :destroy

  accepts_nested_attributes_for :post_images, allow_destroy: true
  accepts_nested_attributes_for :items, allow_destroy: true
  acts_as_taggable
  enum situation: { Working: 0, Gaming: 1 }

  validates :post_images, presence: true, length: { maximum: 4 }
  validates :text, presence: true, length: { maximum: 140 }
  validates :situation, presence: true
  validates :items, length: { maximum: 10}

  default_scope -> { order(created_at: :desc) }
  scope :working, -> { where(situation: 0) }
  scope :gaming, -> { where(situation: 1) }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def bookmarked_by(user)
    bookmarks.where(user_id: user.id).exists?
  end

  # いいねの通知を作成して保存
  def create_notification_favorite!(current_user)
    # 同じユーザーが同じ投稿に連続でいいねしても通知が行かないように通知済みか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, "favorite"])
    # 既にいいねされてない場合、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: "favorite"
      )
      # 自分の投稿に対するいいねの場合は通知済みにする
      if notification.visitor_id == notification.visited_id
        notification.is_checked = true
      end
      # 通知レコードに不備がなければ保存
      notification.save if notification.valid?
    end
  end

  # コメントの通知を作成
  def create_notification_post_comment!(current_user, post_comment_id)
    # 自分以外にコメントしている人を全て取得し全員に通知を送る
    temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_post_comment!(current_user, post_comment_id, temp_id("user_id"))
    end
    # まだ誰もコメントしていない場合は投稿者のみに通知を送る
    save_notification_post_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end

  # 作成したコメントの通知を保存
  def save_notification_post_comment!(current_user, post_comment_id, visited_id)
    # 同じ投稿に複数コメントすることがあるので、1つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: "comment"
    )
    # 自分の投稿に対するコメントの場合は通知済みにする
    if notification.visitor_id == notification.visited_id
      notification.is_checked = true
    end
    # 不備がなければ保存
    notification.save if notification.valid?
  end
end