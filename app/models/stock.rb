class Stock < ApplicationRecord
	belongs_to :item
	belongs_to :warehouse
	enum state: [:agotado, :disponible]
	def total
		total = self.qty_in - self.qty_out 
	end
end
