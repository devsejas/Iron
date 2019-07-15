class Currency < ApplicationRecord
	has_many :currency_rates
	has_many :accounts
	has_many :setting_currency_companies, inverse_of: :currencies, dependent: :destroy
    has_many :companies, through: :setting_currency_companies

	validates :name, presence: true
	validates :symbol, presence: true
	validates :currency_unit_label, presence: true 
	validates :currency_subunit_label, presence: true
	def get_full_name
		get_full_name = self.currency_unit_label+'('+ self.symbol+')'
	end
	def disability
       self.currency_rates.each do |c_r|
       	c_r.update(:state => 'false')
       end
      
	end
	def get_current_currency_rate
		currency_rate = self.currency_rates.where(:state => true).first
	end
	
end
