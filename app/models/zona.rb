class Zona < ApplicationRecord
	has_one :address
	validates :name, presence: true
end
