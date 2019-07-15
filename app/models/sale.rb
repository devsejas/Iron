class Sale < ApplicationRecord
	has_many :sale_details, inverse_of: :sale, dependent: :destroy
	has_many :items, through: :sale_details 

	has_many :payments, inverse_of: :sale, dependent: :destroy
	has_many :payment_type, through: :payments

	has_many :account_sales, inverse_of: :sale, dependent: :destroy
	has_many :accounts, through: :account_sales

	belongs_to :user
	belongs_to :client
	validates :number, presence: true
	validates :date, presence: true
	accepts_nested_attributes_for :sale_details, reject_if: :sale_detail_rejectable?,
									allow_destroy: true
	enum state: [:draft, :confirmed, :cancelado, :anulado]

	def total
		des = self.sub_total ? ((sub_total)*discount_all)/100 : 0
		total = sub_total-des
	end
	def sub_total
		details = self.sale_details
		total = 0.0
		details.flat_map do |d|
			total += d.subtotal
		end
		total
	end
	def total_pagos
		my_payments = self.payments

		total = 0.0
		my_payments.flat_map do |p|
			total += p.rode
		end
		total
	end
	def saldo
		saldo = total - total_pagos
	end
	def iscredit
		if self.credit
			res = "A Credito"
		else
			res = "Al Contado"
		end
	end
	def discount_all
		discount_sal = self.discount
		discount_cli = self.client.discount
		discount_total = discount_cli.to_i + discount_sal.to_i
	end
	# verifica que si s epuede efectivisar la venta  mediante la disponivilidad de credito actual del cliente  en caso de que la venta sea a credito
	def destroy_sale_details_all
		self.sale_details.each do |sale_details|        
        movements = sale_details.movements
        movements.each do |movement|
        stock = Stock.find(movement.stock_id)
        stock.qty_out -= movement.qty_out
        stock.state = 'disponible'
        stock.save
        movement.destroy
        end
        sale_details.destroy
      end
	end
	def is_can_sale
		# limint_credit = self.client && self.sale_details.count > 0 
		can_sale = false
		if self.client.line_credit_available > 0 && self.sale_details.count > 0 
			can_sale = true
		end
		can_sale
	end

	private
		def sale_detail_rejectable?(att)
			att[:item_id].blank? || att[:qty].blank? || att[:price].blank? || att[:qty].to_f <= 0 || att[:price].to_f <= 0
		end
end

