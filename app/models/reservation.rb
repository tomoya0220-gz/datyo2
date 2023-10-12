class Reservation < ApplicationRecord
    belongs_to :user
    validates :note, length: { maximum: 300 }, allow_blank: true
    validates :name, presence: true, unless: :user_id?
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, unless: :user_id?
    
end
