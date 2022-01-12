class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
    @genres = Genre.all
  end

  def genre_items
    @genre = Genre.find(params[:genre_id])
    @item = @genre.items
  end

  def show
  end

end
