class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    
    item = Item.find(params[:item_id])
    @comment = item.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメントしました"
      redirect_to "/items/#{@comment.item.id}"
    else
      flash[:success] = "コメントできませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @comment = Comment.new
    @comments = @comment.comments.includes(:user)
    @comment = Comment.find_by(id: params[:id])
    @user = User.find_by(id: @comment.user_id)
  end
  private

    def comment_params
      params.require(:comment).permit(:text)
    end
end
