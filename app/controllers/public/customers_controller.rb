class Public::CustomersController < ApplicationController
  def show
    @customers = Customer.all
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
