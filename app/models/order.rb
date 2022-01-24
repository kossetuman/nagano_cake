class Order < ApplicationRecord
  enum payment_method: { creditcard: 0, banktransfer: 1 }
end
