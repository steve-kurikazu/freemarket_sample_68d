class OrdersController < ApplicationController
  require 'payjp'

  def index
    @item = Item.find(params[:id])
    @image = @item.images.first
    @sending = Sending.where(user_id: current_user.id).first
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
    if @sending.nil?
      @sending_error_message = "発送先が登録されていません。" 
    else
      @prefecture = Prefecture.find(@sending.prefectures)
    end
  end

  def pay
    item = Item.find([:id])
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    amount: item.price,
    customer: card.customer_id, 
    currency: 'jpy'
  )
  redirect_to done_orders_path
  end
end