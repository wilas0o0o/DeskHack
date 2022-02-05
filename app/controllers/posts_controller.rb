class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
  end

  def index
  end

  def show
  end

  def edit
  end

  def update

  end

  def destroy

  end

  private

    def posts_params
      params.require(:post).permit(:title)
    end

    def ensure_correct_user
      @post = Post.find(params[:id])
      unless @post.user == current_user
        redirect_to book_path(@book)
      end
    end
end
