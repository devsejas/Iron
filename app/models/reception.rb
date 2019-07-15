class Reception < ApplicationRecord
	belongs_to :purchase_order_line
	validates :qty_in, presence: true
	
	def total
		t =  self.purchase_order_line.item_qty - self.purchase_order_line.qty_received 		
	end
end
