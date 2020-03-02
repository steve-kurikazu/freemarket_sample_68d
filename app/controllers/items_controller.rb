class ItemsController < ApplicationController
  before_action :set_item,only: [:show, :edit, :update, :destroy]

  def new
    @item = Item.new
    @images = @item.images.new
    @category_parent_array = Category.where(ancestry: nil).pluck(:name, :id)
  end

  def get_category_children
    @category_children = Category.find_by(id: "#{params[:parent_name]}", ancestry: nil).children
  end 

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
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
    @user = @item.user
    @images = @item.images
    @first_image = @images.first
    @prefecture = Prefecture.find(@item.shipping_area)
  end

  def edit
    @category_parent_array = Category.where(ancestry: nil).pluck(:name, :id)
  end
  
  def update
    if  @item.update(item_update_params)
      redirect_to item_path(@item.id)
    else 
      render :edit 
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      redirect_back(fallback_location: root_path)
    end       
  end

  def search
    @text = params[:search_text]
    @items = Item.search(@text)
    if params[:sort]
      @items = Item.sort(@items, params[:sort])
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :text, :condition, :delivery_fee, :shipping_area, :category_id, :delivery_time, :price, images_attributes: [:photo]).merge(user_id: current_user.id)
  end

  def item_update_params
    params.require(:item).permit(:name, :text, :condition, :delivery_fee, :shipping_area, :delivery_time, :category_id, :price, images_attributes: [:photo, :_destroy, :id]).merge(user_id: current_user.id)
  end

end