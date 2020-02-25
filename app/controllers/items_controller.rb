class ItemsController < ApplicationController
  before_action :set_item,only: [:show, :edit, :destroy]
  def new
    @item = Item.new
    @images = @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to edit_user_path(current_user.id)
    else
      render :new
    end
  end

  def show
    @images = @item.images
    @first_image = @images.first
  end

  def edit
  end

  def update
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :text, :condition, :delivery_fee, :shipping_area, :delivery_time, :price, images_attributes: [:photo]).merge(user_id: current_user.id)
  end

end