class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items
  has_many :addresses
  belongs_to :order

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :postal_code, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :telephone_number, format: { with:  /\A\d{10,11}\z/ }
  validates :email, presence: true

end
