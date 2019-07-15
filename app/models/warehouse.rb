class Warehouse < ApplicationRecord
	has_many :stocks
	belongs_to :company
	validates :ref, presence: true
	validates :name, presence: true
	validates :company_id, presence: true

	def total_price
		# items_warehouse = self.items
		# total = 0.0
		# items_warehouse.flat_map do |i|
		# 	# total += i.stock * i.price
		# end
		# total
	end
	def total_quantity
		# items_warehouse = self.items
		# q = 0
		# items_warehouse.flat_map do |i|
		# 	 #q += i.stock 
		# end
		# q
	end
end
