class SendingsController < ApplicationController
  def new
    @item_id = params[:item_id]
    @sending = Sending.new
  end

  def create
    @sending = Sending.new(sending_params)
    if @sending.save 
      if params[:item_id].present?
        redirect_to new_item_order_path(params[:item_id])
      else
        redirect_to edit_user_path(current_user.id)
      end
    else
      render new_sending_path
    end
  end
  
  private
  def sending_params
    params.require(:sending).permit(:first_name, :last_name, :first_namekana, :last_namekana, :postal_code, :prefectures, :city, :address, :building_name, :tell).merge(user_id: current_user.id)
  end               
end