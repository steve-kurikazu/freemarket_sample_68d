class CardsController < ApplicationController
  before_action :move_to_index 
  require 'payjp'
  def new
    @item_id = params[:item_id]
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
  end

  def create
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to new_card_path
    else
      customer = Payjp::Customer.create(
      description: '登録テスト', 
      email: current_user.email, 
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        if params[:item_id].present?
          redirect_to new_item_order_path(params[:item_id])
        else
          redirect_to edit_user_path(current_user.id)
        end
      else
        redirect_to action: "create"
      end
    end
  end

  def destroy
    card = Card.where(card_id: (params[:id])).first
    if card.user_id === @current_user.id
      if card.blank?
      else
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        customer = Payjp::Customer.retrieve(card.customer_id)
        customer.delete
        card.delete
      end
      respond_to do |format|
        format.js
      end
    else
      redirect_to edit_user_path(current_user.id)
    end
  end
end