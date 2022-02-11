module NotificationsHelper
  # 未確認の通知を検索
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(is_checked: false)
  end
end
