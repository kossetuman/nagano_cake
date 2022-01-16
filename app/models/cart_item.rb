class CartItem < ApplicationRecord
  attachment :image
  belongs_to :customer
  belongs_to :item
  
  def add_tax_price
    (self.price * 1.1).round
  end  
end
