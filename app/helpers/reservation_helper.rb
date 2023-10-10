module ReservationHelper
    def reservation_status_symbol(reservations_count)
        case reservations_count
        when 0
            '⚪︎'
        when 1..10 
            '△'
        else
            '×'
        end
    end
end