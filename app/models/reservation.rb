class Reservation < ApplicationRecord
    belongs_to :user
    validates :note, length: { maximum: 300 }, allow_blank: true
    
    def self.total_reservations_for_time_slot(time_slot)
        where(time_slot: time_slot).sum(:adults) + where(time_slot: time_slot).sum(:children)
    end
    
    def self.total_reservations_for_time_range(start_time, end_time)
        where(time_slot: start_time..end_time).sum(:adults) + where(time_slot: start_time..end_time).sum(:children)
    end
end
