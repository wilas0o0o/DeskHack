class PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    @post.post_images.build
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      dominant_colors = Vision.get_image_data(@post.post_image)
      colors = dominant_colors['colors']
      colors.each do |color|
        dec = (color['color']['red'] << 16) | (color['color']['green'] << 8) | color['color']['blue']
        hex = sprintf('#%06X', dec)
        pixel_fraction = color['pixelFraction']
        @post.post_image.colors.create(hex: hex, pixel_fraction: pixel_fraction)
      end
      redirect_to post_path(@post)
    else
      @post.post_images.build
      render :new
    end
  end

  def index
    if params[:sort_working]
      @posts = Post.working.order(created_at: :desc).page(params[:page]).per(15)
    elsif params[:sort_gaming]
      @posts = Post.gaming.order(created_at: :desc).page(params[:page]).per(15)
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page]).per(15)
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_image = @post.post_image
    @post_comment = PostComment.new
    @item = Item.new
    @colors = @post_image.colors
    @comment_reply = @post.post_comments.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      @post.post_image.colors.destroy_all
      dominant_colors = Vision.get_image_data(@post.post_image)
      colors = dominant_colors['colors']
      colors.each do |color|
        dec = (color['color']['red'] << 16) | (color['color']['green'] << 8) | color['color']['blue']
        hex = sprintf('#%06X', dec)
        pixel_fraction = color['pixelFraction']
        @post.post_image.colors.create(hex: hex, pixel_fraction: pixel_fraction)
      end
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path(@post.user)
  end

  def hashtag
    @tag = Hashtag.find_by(name: params[:name])
    @posts = @tag.posts.page(params[:page]).per(15)
  end

  private

  def post_params
    params.require(:post).
      permit(
        :user_id,
            :situation,
            :text,
            :caption,
            post_images_attributes: [:image, :id, :_destroy],
            items_attributes: [:post_id, :category_id, :image, :name, :manufacturer]
      )
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id
      redirect_to post_path(@post)
    end
  end
end
