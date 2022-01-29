class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  #バリデーション
  validates :amount, inclusion: { in: 1..5 }, allow_nil: true


  def add_tax_price
    (self.price * 1.1).round
  end

  def subtotal
    item.add_tax_price * amount
  end
end
