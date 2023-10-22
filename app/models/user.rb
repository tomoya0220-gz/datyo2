class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line]
  
  has_many :reservations, dependent: :destroy

  validates :name, presence: true, unless: :guest?
  validates :email, presence: true, unless: :guest?
  validates :phone_number, presence: true, unless: :guest?
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = ''
      user.phone_number = ''
    end
  end
  
  def guest?
    email == 'guest@example.com'
  end
end
