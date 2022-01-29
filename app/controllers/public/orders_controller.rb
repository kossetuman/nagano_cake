class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @cart_items = current_customer.cart_items.all #ログインユーザーのカートアイテムをすべて取り出して＠cart_itemsに格納
    @cart_items.each do |cart_item|
      detail = @order.details.new
      detail.item_id = cart_item.item_id
      detail.amount = cart_item.amount
      detail.tax_included_price = cart_item.item.price * 1.1
      detail.save
    end
    @cart_items.destroy_all
    redirect_to thanks_orders_path
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
    @detail = Detail.new
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params) #new画面から渡ってきたデータを@orderに格納
    @order.customer_id = current_customer.id
    @order.postage = 800
    if params[:order][:address_option] == "1" #viewで定義しているaddress_optionが１だった場合にこの処理を行う
      @order.address = current_customer.address #@order.addressにcurrent_customerのaddressを格納
      @order.name = current_customer.first_name + current_customer.last_name #@order.nameにcurrent_customerのlast_nameとfirst_nameを格納
      @order.postal_code = current_customer.postal_code #@order.postal_codeにcurrent_customerのpostal_codeを格納
    elsif params[:order][:address_option] == "2" ##viewで定義しているaddress_optionが2だった場合にこの処理を行う
      address = Address.find(params[:order][:address_id]) #addressにAddressモデルのaddressのidを持ってくる
      @order.address = address.address #@order.addressにaddressに入った中のaddressの情報を格納
      @order.name = address.name #@order.nameにaddressに入った中のnameの情報を格納
      @order.postal_code = address.postal_code #@order.postal_codeにaddressに入った中のpostal_codeの情報を格納
    else #viewで定義しているaddress_optionが1と2以外だった場合にこの処理を行う
      @address = Address.new(address_params) #@addressに(address_params)の情報を持ってきて空のインスタンスに格納
      @address.customer_id = current_customer.id #@address.customer_idに外部キーのcustomer.idを格納
      unless @address.save #もし保存ができなかった場合に34行目の処理を実行
        render :confirm
      else #もし保存できたなら36行目以降の処理を実行
        @order.address = @address.address #@order.addressに31行目で@addressに入れた情報の中のaddressを格納
        @order.name = @address.name #@order.nameに31行目で@addressに入れた情報の中のnameを格納
        @order.postal_code = @address.postal_code #@order.postal_codeに31行目で@addressに入れた情報の中のpostal_codeを格納
      end

    end
  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:address, :name, :postal_code, :total_payment, :payment_method, :postage)
  end

  def address_params
    params.require(:address).permit(:address, :name, :postal_code)
  end

end
