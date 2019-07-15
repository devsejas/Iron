class Presentation < ApplicationRecord
    mount_uploader :image_presentation, ImagePresentationUploader
	belongs_to :unit
	belongs_to :item
	def price
		current_price = self.item.price_default
		 res = self.qty*current_price 
	end
end
