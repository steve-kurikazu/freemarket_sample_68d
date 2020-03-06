class OrdersController < ApplicationController
  before_action :move_to_index
  require 'payjp'
  def new
    @item = Item.find(params[:item_id])
    @image = @item.images.first
    @sending = Sending.where(user_id: current_user.id).first
    @order = Order.new
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
    if order_params[:sending_id] == "" && order_params[:card_id] == nil 
      redirect_to new_item_order_path(order_params[:item_id]), flash: {alert1: '発送先が入力されていません', alert2: '支払方法が選択されていません'}
    elsif order_params[:sending_id] == ""
      redirect_to new_item_order_path(order_params[:item_id]), flash: {alert1: '発送先が入力されていません'}
    elsif order_params[:card_id] == nil
      redirect_to new_item_order_path(order_params[:item_id]), flash: {alert2: '支払方法が選択されていません'}
    else 
      card = Card.find_by(card_id: order_params[:card_id])
      @order = Order.new(order_params.except(:card_id))
      @order[:card_id] = card.id
      @item = Item.find(@order.item_id)
      @image = @item.images.first
      if @order.save && @item.status == 0
        Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
        Payjp::Charge.create(
        amount: @item.price,
        customer: card.customer_id, 
        currency: 'jpy'
        )
        @item.update(status: 1)
      else
        @order_error_message = "商品は売り切れです。ひと足遅かったようだな！！"
      end
    end
  end
  
  private
  def order_params
    params.require(:order).permit(:item_id, :sending_id, :card_id).merge(user_id: current_user.id)
  end
end