class RelationshipsController < ApplicationController
  
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    user.create_notification_follow!(current_user)
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to request.referer
  end

  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.page(params[:page]).per(30)
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.page(params[:page]).per(30)
  end

end
