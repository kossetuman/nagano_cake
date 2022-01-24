class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def create
    @cart_items = current_customer.cart_items.all #ログインユーザーのカートアイテムをすべて取り出して＠cart_itemsに格納

  end

  def index
  end

  def show
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params) #new画面から渡ってきたデータを@orderに入れます
    if params[:order][:address_option] == "1" #viewで定義しているaddress_optionが１だった場合にこの処理を行う
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      @order.postal_code = current_customer.postal_code
    elsif params[:order][:address_option] == "2" ##viewで定義しているaddress_optionが2だった場合にこの処理を行う
      address = Address.find(params[:address][:id])
    end
  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:address, :name, :postal_code, :postage, :total_payment, :payment_method)
  end

end
