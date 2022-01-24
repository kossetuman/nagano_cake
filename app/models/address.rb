class Address < ApplicationRecord
  
  belongs_to :customer
  
  # バリデーション機能
  validates :name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  
  def address_all
    self.postal_code + self.address + self.name
  end
end
