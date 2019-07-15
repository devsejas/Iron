class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
   mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sales
  has_many :clients
  belongs_to :rol
  has_many :user_modulos, inverse_of: :user, dependent: :destroy
  has_many :modulos, through: :user_modulos
  
  def my_clients
    cant = self.clients.count
    cant
  end
  def my_sales
    cant = self.sales.count
    cant
  end
end

