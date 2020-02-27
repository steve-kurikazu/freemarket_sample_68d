class ItemsController < ApplicationController
  before_action :set_item,only: [:show, :edit, :destroy]
  def new
    @item = Item.new
    @images = @item.images.new


  def create
    
    @item = Item.new(item_params)
   
    if @item.save
      redirect_to root_path
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
    if @item.destroy
      redirect_to root_path
    else
      redirect_back(fallback_location: root_path)
    end
       
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :text, :condition, :delivery_fee, :shipping_area, :category_id, :delivery_time, :price, images_attributes: [:photo]).merge(user_id: current_user.id)
  
  end

end