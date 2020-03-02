class SendingsController < ApplicationController
  before_action :move_to_index 
  before_action :set_sending, only: [:edit, :update]
  before_action :identity_verification, only: [:edit, :update]
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

  def edit
  end

  def update
    if @sending.update(sending_params)
      redirect_to edit_user_path(current_user.id)
    else 
      render :edit 
    end
  end
  
  private
  def sending_params
    params.require(:sending).permit(:first_name, :last_name, :first_namekana, :last_namekana, :postal_code, :prefectures, :city, :address, :building_name, :tell).merge(user_id: current_user.id)
  end

  def set_sending
    @sending = Sending.find_by(user_id: current_user.id)      
  end 
  
  def identity_verification
    redirect_to edit_user_path(current_user.id) unless @sending.user_id === @current_user.id
  end
end