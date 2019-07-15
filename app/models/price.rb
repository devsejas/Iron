class Price < ApplicationRecord
	  belongs_to :item
	  belongs_to :price_list

	  def name
	  	name = self.price_list.name
	  end
end
