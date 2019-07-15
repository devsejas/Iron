

class Payment < ApplicationRecord
	belongs_to :sale
	belongs_to :payment_type
	belongs_to :account
	enum state: [:draft, :confirmed]
	validates :account, presence: true
	# validates :account, numericality: true
	validates_numericality_of :rode, :greater_than => 0
	def get_discount_payment
		# self.qty ? ((qty * unit_price)*discount)/100 : 0
	end
end
