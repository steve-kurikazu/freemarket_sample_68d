class SendingsController < ApplicationController
  def new
    @sending = Sending.new
  end

  def create
    @sending = Sending.new(sending_params)
    if  @sending.save 
      redirect_to user_path(1)
    else

      render new_sending_path
    end
    #redirect_to new_sending_path
  
end

  def show
    @sendings = Sending.new
  end

  def edit
  end

  private
  def sending_params
    params.require(:sending).permit(:first_name, :last_name, :first_namekana, :last_namekana, :postal_code, :prefectures, :city, :address, :building_name, :tell).merge(user_id: 1)
  end               
end