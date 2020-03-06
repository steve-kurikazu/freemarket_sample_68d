class LikesController < ApplicationController
  before_action :authenticate_user!
    
  def create
    @like = Like.new(user_id: current_user.id, item_id: params[:item_id])

      redirect_to item_path(params[:item_id]) if @like.save
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, item_id: params[:item_id])
     
      redirect_to item_path(params[:item_id]) if @like.destroy 

  end

end


