class Category < ApplicationRecord
	validates :name, presence: true
	validates_with ValidateUnaccent, model: self
end
