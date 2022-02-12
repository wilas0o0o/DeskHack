class SearchesController < ApplicationController

  def search
    @content = params[:content]
    @model = params[:model]
    if @model == "user"
      @records = User.search_for(@content).page(params[:page]).per(30)
    elsif @model == "tag"
      @records = Post.tagged_with(params[:content]).page(params[:page]).per(15)
    end
  end
end
