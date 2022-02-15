class PostCommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.new(post_comment_params)
    @post_comment.user_id = current_user.id
    if @post_comment.save
      @post.create_notification_post_comment!(current_user, @post_comment.id)
    else
      @post = Post.find(params[:post_id])
      render :error
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    post_comment = @post.post_comments.find(params[:id])
    post_comment.destroy
  end

  private

    def post_comment_params
      params.require(:post_comment).permit(:comment)
    end

end
