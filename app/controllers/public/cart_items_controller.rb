class Public::CartItemsController < ApplicationController

  def create
    @cart_item = CartItem.new(cart_item_params) #@cart_itemに空のインスタンスを渡す。(引数にcart_item_paramsを持たせストロングパラメータで定義したカラムの情報を持ってくる)
    @cart_item.customer_id = current_customer.id #@cart_item.customer_idにcurrent_customer.idを代入。これで必要な情報(:amount, :item_id, :customer_id)が揃った
    if @cart_item.amount == nil
       @genres = Genre.all
       @item = @cart_item.item
       @cart_item = CartItem.new
       render "public/items/show"
    else
      if CartItem.exists?(item_id: @cart_item.item_id, customer_id: @cart_item.customer_id) #もしカート内に同じ商品が存在したらの判断(true)
        exists_cart_item = CartItem.find_by(item_id: @cart_item.item_id, customer_id: @cart_item.customer_id) #すでにカート内にある商品データをexists_cart_itemに格納
        exists_cart_item.update(amount: exists_cart_item.amount + @cart_item.amount) #カラム(:amount)にexists_cart_item.amount(すでにカートにある１つの商品の個数) + @cart_item.amount(新たにカートに登録された1つの商品の個数)で更新して保存。
        redirect_to cart_items_path #更新後にcart_items_pathに遷移
      else #もしカート内に同じ商品が存在したらの判断(false)
        @cart_item.save #@cart_itemを新規登録して保存
        redirect_to cart_items_path #新規登録後にcart_items_pathに遷移
      end
    end
  end

  def index
    @cart_item = CartItem.new
    @cart_items = current_customer.cart_items
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path(@cart_item.id)
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    if @cart_item.destroy
      redirect_to cart_items_path, notice: "削除が完了しました"
    else
      redirect_to cart_items_path, alert: "削除が失敗しました"
    end
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    if @cart_items.destroy_all
      redirect_to cart_items_path ,notice: '全て削除しました'
    else
      redirect_to cart_items_path ,alert: '削除が失敗しました'
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end
end
