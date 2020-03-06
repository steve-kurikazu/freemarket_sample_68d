class ItemsController < ApplicationController
  before_action :move_to_index, except: [:show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :identity_verification, only: [:edit, :update, :destroy]
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
    @search = Item.ransack(params[:q])
    @like = current_user.likes.find_by(item_id: params[:id])
    @grandchild_id = @item.category_id
    @grandchild = Category.find(@grandchild_id)
    @child = @grandchild.parent
    @parent = @child.parent
  end

  def edit
    @parents = Category.where(ancestry:nil)
    # 編集する商品を選択
    @item = Item.find(params[:id])
      # 登録されている商品の孫カテゴリーのレコードを取得
      @selected_grandchild_category = @item.category
      @selected_child_category = @selected_grandchild_category.parent
      @selected_parent_category = @selected_child_category.parent
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
    # 以下、ransackによる詳細検索
    if params[:q]
      params[:q][:name_cont_all] = params[:q][:search_text].split(/[\p{blank}\s]+/)
      @search = Item.ransack(params[:q])
      @items = @search.result
      @text = params.dig(:q,:search_text)
      if params.dig(:q,:sorts)
        @items = Item.sort(@items, params.dig(:q,:sorts))
      end
    else
      @search = Item.ransack(params[:q])
    end
    
    @category_parent_array = Category.where(ancestry: nil).pluck(:name, :id)
    @category_parent_array.prepend(["すべて", ""])
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def identity_verification
    redirect_to edit_user_path(current_user.id) unless @item.user_id === @current_user.id
  end
  def item_params
    params.require(:item).permit(:name, :text, :condition, :delivery_fee, :shipping_area, :category_id, :delivery_time, :price, images_attributes: [:photo]).merge(user_id: current_user.id, category_id: params[:category_id])
  end

  def item_update_params
    if params[:category_id]
      params.require(:item).permit(:name, :text, :condition, :category_id, :delivery_fee, :shipping_area, :delivery_time, :price, images_attributes: [:photo, :_destroy, :id]).merge(user_id: current_user.id, category_id: params[:category_id])
    else
      params.require(:item).permit(:name, :text, :condition, :delivery_fee, :shipping_area, :delivery_time, :price, images_attributes: [:photo, :_destroy, :id]).merge(user_id: current_user.id)
    end
  end
end