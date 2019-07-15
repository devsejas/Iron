class Country < ApplicationRecord
	has_many :brands
	has_one :address
	validates :name, presence: true
	validates :name, uniqueness: true
end
