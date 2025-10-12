class OrdersController < ApplicationController
  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      pay_item(@order)
      @order.save
      redirect_to root_path
    else
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:price).merge(token: params[:token])
  end

  def pay_item(order)
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: order.item[:price],
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
