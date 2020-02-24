class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    Item.create(params[:item_image])
    @new_item = Item.last
    image = image_params[:image]
    Image.create(item_id: @new_item.id, item_image: image_params[:item_image])
  end

  def show
    @item = Item.find(params[:id])
    @images = @item.images

  end

  def edit
  end

  def update
  end

  def destroy
  end
  

  private

  def image_params
    params.require(:item).permit(:item_image)
  end

end

