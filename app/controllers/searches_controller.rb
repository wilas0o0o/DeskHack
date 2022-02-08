class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @content = params[:content]
    @model = params[:model]
    if @model == "user"
      @records = User.search_for(@content)
      @username = params[:content]
    elsif @model == "tag"
      @records = Post.tagged_with(params[:content])
      @tag = params[:content]
    end
  end
end
