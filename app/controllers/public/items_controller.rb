class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
    @items = Item.page(params[:page]).per(4)
    @genres = Genre.all

  end

  def genre_items
    @genre = Genre.find(params[:genre_id])
    @item = @genre.items
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end
