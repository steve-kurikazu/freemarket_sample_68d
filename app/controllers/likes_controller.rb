class LikesController < ApplicationController
  before_action :authenticate_user!
    
  def create
    @like = Like.new(user_id: current_user.id, item_id: params[:item_id])
    
    # 変数@likeを保存してください
    if @like.save
      redirect_to item_path(params[:item_id])
    else
      redirect_to item_path(params[:item_id])
    end
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, item_id: params[:item_id])
    if @like.destroy  
      redirect_to item_path(params[:item_id])
    else
      redirect_to item_path(params[:item_id])
    end
  end

end


