class UsersController < ApplicationController
  before_action :move_to_index, except: :new
  before_action :user_sending, except: :new
  require 'payjp'

  def new
    @user = User.new
  end
  
  def edit
    @profile = Profile.find_by(user_id:current_user.id)
    unless @profile.present?
      @profile = Profile.new
    end

    @sending = Sending.find_by(user_id: current_user.id)

    # クレジットのための記載
    cards = Card.where(user_id: current_user.id)
    if cards.length == 0
      @card_error_message = "カードが登録されていません。" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      @default_cards_information = []
      cards.each_with_index do |card, i|
        customer = Payjp::Customer.retrieve(card.customer_id)
        @default_cards_information[i] = customer.cards.retrieve(card.card_id)
      end
    end
    @myitems = Item.where(user_id: current_user.id)
  end

  def update
    if @user.update(sending_param)
      redirect_to edit_user_path(current_user.id)
    else
      render :edit
    end
  end

  private
  def user_sending
    @user = User.find(current_user.id)
  end

  def sending_param
    params.require(:user).permit(:nickname, :lastname, :firstname, :lastname_kana, :firstname_kana, :birth_year, :birth_month, :birth_day)
  end

end
