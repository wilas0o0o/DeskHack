class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    @post.post_images.build
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def index
    if params[:sort_working]
      @posts = Post.working
    elsif params[:sort_gaming]
      @posts = Post.gaming
    elsif @tag = params[:tag]
      @posts = Post.tagged_with(params[:tag])
    else
      @posts = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
    post_images = @post.post_images
    @first_image = post_images.first
    @post_comment = PostComment.new
    @tags = @post.tag_counts_on(:tags)
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
    redirect_to user_path(@post.user)
  end

  private

    def post_params
      params.require(:post).permit(:user_id, :situation, :text, :tag_list, post_images_attributes:[:image, :id])
    end

    def ensure_correct_user
      @post = Post.find(params[:id])
      unless @post.user_id == current_user.id
        redirect_to post_path(@post)
      end
    end
end
