class Supplier < ApplicationRecord
	mount_uploader :imagesupplier, ImagesupplierUploader
	has_many :purchase_orders
	belongs_to :address
	
    validates :name, presence: true
	validates :address_id, presence: true
	validates :nit, presence: true

	enum is_company: [:individual, :company]
	enum state: [:draft, :confirmed]
end
