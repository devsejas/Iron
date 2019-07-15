class Client < ApplicationRecord
	 mount_uploader :photo, PhotoUploader
	 has_many :sales
	 has_many :contacts
	 belongs_to :address
	 belongs_to :price_list
	 validates :name, presence: true
	 validates :address_id, presence: true
 def phones
	 	 	phone = self.phone
	 	 	mobil = self.mobile	 	 		 	
	 	 	res = phone+' - '+ mobil
	end
	def get_saldo_total
		sales = self.sales

		total = 0.0
		sales.flat_map do |s|
			total += s.total
		end
		total
	end

	def get_asignado
		user = User.find(self.asig_a_user_id)
		name = user.name
	end
	# iobtenemos todos los pagos del cliente
	def payments_all
		payments = Array.new
		self.sales.each do |sale|
			sale.payments.each do |payment|
				payments.push(payment)
			end			
		end	
		payments	
	end
	def payments_active
		
	end
	# obtenemos linea de credito disponible para el credito actual asignado
	def line_credit_available
		sales = self.sales.where(credit: true)
		total = 0.0
		sales.flat_map do |s|
			total += s.saldo
		end
		 res = self.credit_limit - total
		
	end
	  
end

