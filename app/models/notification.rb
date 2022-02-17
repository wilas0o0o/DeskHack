class Notification < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true
  belongs_to :visitor, class_name: "User", optional: true
  belongs_to :visited, class_name: "User", optional: true

  def checked_notification
    passive_notifications.where(is_checked: false).each do |notification|
      notification.update_attributes(is_checked: true)
    end
  end
end
