class ItemsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @item = @post.items.new(item_params)
    if @item.save
    else
      @post = Post.find(params[:post_id])
      render :error
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @item = @post.items.find(params[:id]).destroy
  end

  private
    def item_params
      params.require(:item).permit(:category_id, :name, :manufacturer, :image)
    end

end
