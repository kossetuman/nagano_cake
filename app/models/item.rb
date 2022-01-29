class Item < ApplicationRecord
  attachment :image
  belongs_to :genre
  has_many :cart_items
  has_many :details

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true


  def add_tax_price
    (self.price * 1.1).round
  end

end
