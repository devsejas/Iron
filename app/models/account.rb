class Account < ApplicationRecord
	has_many :taxes
	belongs_to :currency	
	has_many :account_sales, inverse_of: :account, dependent: :destroy
	has_many :sales, through: :account_sales
	has_many :payments

	def total_a_cobrar
		sales = self.sales

		total = 0.0
		sales.flat_map do |s|
			total += s.saldo
		end
		total
	end

end
