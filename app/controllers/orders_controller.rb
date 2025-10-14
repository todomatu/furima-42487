class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :move_to_root_if_not_signed_in, only: [:index, :create]
  before_action :authorize_user!, only: [:index, :create]
  before_action :move_to_root_if_soled_out, only: [:index, :create]
  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      ActiveRecord::Base.transaction do
        @order_address.save!
        pay_item!(@order_address)
      end
      redirect_to root_path
    else
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :item_prefecture_id, :city, :address, :building,
                                          :phone_number).merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id])
  end

  def pay_item(order)
    item = Item.find(order.item_id)
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: item[:price],
      card: order.token,
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_root_if_not_signed_in
    redirect_to root_path unless user_signed_in?
  end

  def authorize_user!
    redirect_to root_path if current_user == @item.user
  end

  def move_to_root_if_soled_out
    redirect_to root_path if Order.find_by(item_id: params[:item_id])
  end
end
