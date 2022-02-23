class NotificationsController < ApplicationController
  def check
    current_user.checked_notification
  end
end
