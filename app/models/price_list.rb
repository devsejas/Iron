class PriceList < ApplicationRecord
	
	has_many :prices, inverse_of: :price_list, dependent: :destroy
	has_many :items, through: :prices
	has_many :price_lists
end
