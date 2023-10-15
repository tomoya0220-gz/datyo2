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
        @reservations = Reservation.new
        @reservations.date = params[:date]
        @reservations.time_slot = params[:time_slot]
        if user_signed_in?
            @reservations.user = current_user
            # LINEでログインしている場合
            if current_user.provider == 'line'
                @reservations.name = current_user.line_name
                @reservations.email = current_user.line_email
                @reservations.phone_number = current_user.line_phone_number                
            end    
        end        
    end

    def create
        @reservation = Reservation.new(reservation_params)
        @reservation.time_slot =
        @reservation.number_of_people =
        @reservation.note = 
        @reservation.name = current_user.name
        @reservation.email = current_user.email
        @reservation.phone_number = current_user.phone_number

        if @reservation.save
            flash[:notice] = '予約が完了しました。'
            redirect_to index_reservation_path 
        else
            flash[:alert] = '予約に失敗しました。もう一度やり直してください。'
            render :new
        end
    end

    private

    def reservation_params
        params.require(:reservation).permit(:date, :time_slot, :number_of_people, :note, :name, :email, :phone_number)
    end
end