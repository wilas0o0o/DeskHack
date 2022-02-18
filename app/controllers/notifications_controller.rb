class NotificationsController < ApplicationController
  def check
    current_user.passive_notifications.where(is_checked: false).each do |notification|
      notification.update_attributes(is_checked: true)
    end
  end
end
