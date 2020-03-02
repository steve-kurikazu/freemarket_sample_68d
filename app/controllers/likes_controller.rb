class LikesController < ApplicationController
  before_action :authenticate_user!
    
  def create
    @like = Like.new(user_id: current_user.id, item_id: params[:item_id])
    
    # 変数@likeを保存してください
    @like.save
    
    # 投稿詳細ページにリダイレクトしてください
    redirect_to item_path(params[:item_id])
    
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, item_id: params[:item_id])
    @like.destroy
    redirect_to item_path(params[:item_id])
  end

end


