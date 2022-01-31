class Order < ApplicationRecord
  enum payment_method: { creditcard: 0, banktransfer: 1 }
  enum status: { waiting_for_deposit: 0, payment_confirmation: 1, production: 2, ready_to_ship: 3, sent: 4 }

  validates :total_payment, presence: true
  validates :address, presence: true
  validates :postal_code, format: { with: /\A\d{7}\z/ }
  validates :payment_method, presence: true

  has_many :details
  belongs_to :customer
end
