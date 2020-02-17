class SendingsController < ApplicationController
  def new
    @sending = Sending.new
  end

  def create
    Sending.create(sending_params)
  end

  def show
    @sendings = Sending.new
  end

  private
  def sending_params
    params.require(:sending).permit(:content)
  end
end
