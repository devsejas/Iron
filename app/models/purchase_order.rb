class PurchaseOrder < ApplicationRecord
	belongs_to :supplier
	belongs_to :payment_term
	has_many :purchase_order_lines, inverse_of: :purchase_order, dependent: :destroy
	has_many :items, through: :purchase_order_lines

	enum state: [:draft, :borrador, :confirmado, :comprado]

	def subtotal
		purchase_order_lines = self.purchase_order_lines

		stotal = 0.0
		purchase_order_lines.flat_map do |pol|
			stotal += pol.subtotal
		end
		stotal
		
	end
	def total_tax
		purchase_order_lines = self.purchase_order_lines

		total_tax = 0.0
		purchase_order_lines.flat_map do |pol|
			total_tax += pol.price_tax
		end
		total_tax		
	end
	def total
		total =subtotal+total_tax
	end
	def confirmed
		purchase_order_lines = self.purchase_order_lines

		conf = true
		purchase_order_lines.flat_map do |pol|
			if pol.state == 'borrador'
				conf = false
			end
			
		end
		conf		
	end
	
end
