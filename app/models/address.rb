class Address < ApplicationRecord

  belongs_to :customer

  # バリデーション機能
  validates :name, presence: true
  validates :postal_code, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true

  def full_address
    '〒' + postal_code + '' + address + '' + name
  end
end
