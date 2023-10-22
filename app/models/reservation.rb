class Reservation < ApplicationRecord
    belongs_to :user
    validates :note, length: { maximum: 300 }, allow_blank: true
        
end
