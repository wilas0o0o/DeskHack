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
      redirect_to post_path(@post)
    else
      @post.post_images.build
      render :new
    end
  end

  def index
    if params[:sort_working]
      @posts = Post.working.page(params[:page]).per(15)
    elsif params[:sort_gaming]
      @posts = Post.gaming.page(params[:page]).per(15)
    elsif @tag = params[:tag]
      @posts = Post.tagged_with(params[:tag]).page(params[:page]).per(15)
    else
      @posts = Post.all.page(params[:page]).per(15)
    end
  end

  def show
    @post = Post.find(params[:id])
    post_images = @post.post_images
    @first_image = post_images.to_a.first
    @items = @post.items
    @post_comment = PostComment.new
    @tags = @post.tag_counts_on(:tags)
  end

  def edit
    # @post.items.each do |item|
    #   item.image.cache! unless item.image.blank?
    # end

  end

  def update

    pre_count  = @post.items.count
    if @post.update(post_update_params)

    # @post.items.each.with_index(1) do |item, index|
    #   if index <= pre_count
    #     item.destroy
    #   end
    # end

      # @post.items.destroy_all
      # params[:post][:items_attributes].each do |item|
      #   @post.items.create(category_id: item[1][:category_id], image: item[1][:image], name: item[1][:name], manufacturer: item[1][:manufacturer])
      # end
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
      params.require(:post).permit(:user_id, :situation, :text, :tag_list, post_images_attributes:[:image, :id, :_destroy],
                                                                           items_attributes: [:post_id, :category_id, :image, :name, :manufacturer])
    end

    def post_update_params
      params.require(:post).permit(:user_id, :situation, :text, :tag_list, post_images_attributes:[:image, :id, :_destroy])
    end

    def ensure_correct_user
      @post = Post.find(params[:id])
      unless @post.user_id == current_user.id
        redirect_to post_path(@post)
      end
    end
end
