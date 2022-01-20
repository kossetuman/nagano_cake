class Public::CartItemsController < ApplicationController

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if @cart_item.save
      redirect_to cart_items_path
    else
      @genres = Genre.all
      @item = Item.find(params[:cart_item][:item_id])
      @cart_item = CartItem.new
      render 'public/items/show', alert: '個数を選択してください'
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
