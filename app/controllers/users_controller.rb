class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
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
    @user = User.find(params[:id])
    bookmarked_post_ids = @user.bookmarks.pluck(:post_id)
    @posts = Post.where(id: bookmarked_post_ids)
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :avatar)
    end

    def ensure_correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to user_path(current_user)
      end
    end
end
