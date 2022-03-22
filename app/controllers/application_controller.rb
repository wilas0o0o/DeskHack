class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:top]
  before_action :set_notifications

  protected

  def after_sign_in_path_for(resource)
    posts_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :username])
  end

  def set_notifications
    if user_signed_in?
      @notifications = current_user.passive_notifications.
        order(created_at: :desc).
        page(params[:page]).per(10)
    end
  end
end
