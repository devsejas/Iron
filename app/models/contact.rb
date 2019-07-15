class Contact < ApplicationRecord
  mount_uploader :profile, ProfileUploader
  belongs_to :client
end
