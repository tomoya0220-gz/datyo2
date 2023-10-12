class ReservationsController < ApplicationController
    before_action :authenticate_user!

    def index
        #1ヶ月のカレンダー表示
        require "date"
        @start_date = Date.today
        @end_date = @start_date + 1.month
        @dates = (@start_date..@end_date).to_a
    end

    def show
        #日にち詳細画面に遷移して予約状況を示す
        @date = Date.parse(params[:date])
        @time_slots = (18..20).flat_map { |hour| ["#{hour}:00", "#{hour}:30"] }
        @reservations = Reservation.where(date: @date).group(:time_slot).sum(:number_of_people)
    end

    def new
        #予約を確定させていく画面
        @reservation = Reservation.new(reservation_params)
        if user_signed_in?
        @reservation.name = current_user.name
        @reservation.email = current_user.email
        @reservation.phone_number = current_user.phone_number
        end        
    end
end