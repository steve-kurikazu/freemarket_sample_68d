class UsersController < ApplicationController
  require 'payjp'
  def edit
    @user = User.find(current_user.id)
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
end
