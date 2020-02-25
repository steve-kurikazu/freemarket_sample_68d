class SendingsController < ApplicationController
  def new
    @sending = Sending.new
  end

  def create
    @sending = Sending.new(sending_params)
    if  @sending.save 
      redirect_to edit_user_path(current_user.id)
    else

      render new_sending_path
    end
    
  
end

  def show
    @sendings = Sending.new
  end

  def edit
  end

  private
  def sending_params
    params.require(:sending).permit(:first_name, :last_name, :first_namekana, :last_namekana, :postal_code, :prefectures, :city, :address, :building_name, :tell).merge(user_id: current_user.id)
  end               
end