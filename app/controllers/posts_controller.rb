class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    if params[:sort_working]
      @posts = Post.working
    elsif params[:sort_gaming]
      @posts = Post.gaming
    else
      @posts = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

    def post_params
      params.require(:post).permit(:user_id, :situation, :text, { images: [] })
    end

    def ensure_correct_user
      @post = Post.find(params[:id])
      unless @post.user_id == current_user.id
        redirect_to book_path(@book)
      end
    end
end
