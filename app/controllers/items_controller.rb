class ItemsController < ApplicationController
  def new
    @item = Item.new
    @images = @item.images.new
  end

  def create
    @item = Item.new(item_params)
    
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :text, :condition, :delivery_fee, :shipping_area, :delivery_time, :price, images_attributes: [:photo]).merge(user_id: current_user.id)
  end

end