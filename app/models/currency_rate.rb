class CurrencyRate < ApplicationRecord
	belongs_to :currency
    validates :rate, presence: true
     validates :currency_id, presence: true


	def get_currency_ref
		 name = Currency.find(self.currency_ref).name
	end
	def get_symbol
		name = Currency.find(self.currency_ref).symbol
	end
	
end
