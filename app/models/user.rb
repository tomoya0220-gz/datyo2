class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line]
  
  has_many :reservations, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
  
end
