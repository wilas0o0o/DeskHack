class RelationshipsController < ApplicationController
  def create
    @user = User.find_by(username: params[:user_id])
    current_user.follow(@user)
    @user.create_notification_follow!(current_user)
  end

  def destroy
    @user = User.find_by(username: params[:user_id])
    current_user.unfollow(@user)
  end

  def followings
    @user = User.find_by(username: params[:user_id])
    @users = @user.followings.page(params[:page]).per(30)
  end

  def followers
    @user = User.find_by(username: params[:user_id])
    @users = @user.followers.page(params[:page]).per(30)
  end
end
