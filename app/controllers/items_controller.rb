class ItemsController < ApplicationController

  def create
  end

  def destroy
  end

  private
    def item_params
      params.require(:item).permit(:category_id, :name, :manufacturer, :image)
    end

end
