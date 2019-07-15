class PaymentType < ApplicationRecord
	  has_many :payments, inverse_of: :payment_type, dependent: :destroy
  	  has_many :sales, through: :payments
end
