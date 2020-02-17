class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    Item.create(params[:image])
    @new_item = Item.last
    Image.create(item_id: @new_item.id, item_image: image_params[:image])
  end

  private

  def image_params
    params.require(:item).permit(:image)
  end

end

