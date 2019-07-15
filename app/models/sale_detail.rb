class SaleDetail < ApplicationRecord
	belongs_to :sale
	belongs_to :item
	has_many  :movements
	validates :item_id, presence: true
	validates :qty, presence: true
	validates :price, presence: true
	validates :discount, presence: true

	accepts_nested_attributes_for :item

	def subtotal
		self.qty ? qty * unit_price - get_discount : 0
	end

	def unit_price
		if persisted?
			price
		else
			item ? item.price : 0
		end
	end
	def get_discount
		self.qty ? ((qty * unit_price)*discount)/100 : 0
	end
	def price_select
		
	end
	def current_available_credit
		total = self.sale.client.line_credit_available
		current_price_item = self.subtotal
		res = total+current_price_item

	end

end


