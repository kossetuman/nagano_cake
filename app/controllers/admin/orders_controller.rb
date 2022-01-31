class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.details
    @postage = 800
  end

  def update
  end

end
