class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :withdrawal]
  before_action :ensure_guest_user, only: [:edit, :update]

  def show
    @user = User.find_by(username: params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(15)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def bookmarked
    @user = User.find_by(username: params[:id])
    bookmarked_post_ids = @user.bookmarks.pluck(:post_id)
    @posts = Post.where(id: bookmarked_post_ids).
      order(created_at: :desc).page(params[:page]).per(15)
  end

  def withdrawal
    @user.update(deleted_at: Time.current)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :avatar)
  end

  def ensure_correct_user
    @user = User.find_by(username: params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def ensure_guest_user
    @user = User.find_by(username: params[:id])
    if @user.name == "guest_user"
      redirect_to user_path(current_user), notice: 'ゲストユーザーはユーザー編集画面へ遷移できません。'
    end
  end
end
