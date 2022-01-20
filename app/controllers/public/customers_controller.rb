class Public::CustomersController < ApplicationController
  def show
    @customers = current_customer
  end

  def edit
  end

  def update
  end

  def unsubscribe_confirmation
  end

  def unsubscribe
  end
end
