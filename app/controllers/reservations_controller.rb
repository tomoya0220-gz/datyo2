class ReservationsController < ApplicationController
    before_action :authenticate_user!

    def index
        #1ヶ月のカレンダー表示
        require "date"
        @start_date = Date.today
        @end_date = @start_date + 1.month
        @dates = (@start_date..@end_date).to_a
        @reservations = current_user.reservations
    end

    def show
        #日にち詳細画面に遷移して予約状況を示す
        @date = Date.parse(params[:date])
        @time_slots = (18..20).flat_map { |hour| ["#{hour}:00", "#{hour}:30"] }
        @reservations = Reservation.where(date: @date).group(:time_slot).sum(:adults)
    end

    def new
        #予約を確定させていく画面
        @reservation = Reservation.new
        @reservation.date = params[:date]
        @reservation.time_slot = params[:time_slot]
        if user_signed_in?
            @reservation.user = current_user
        end        
    end

    def create

        @reservation = Reservation.new(date: params[:date], time_slot: params[:time_slot], adults: params[:adults], children: params[:children], note: params[:note])

        temp_name = params[:reservation][:name]
        temp_email = params[:reservation][:email]
        temp_phone_number = params[:reservation][:phone_number]
        @reservation.user = current_user
        
        if current_user.guest? && (temp_name.blank? || temp_email.blank? || temp_phone_number.blank?)
            flash[:alert] = "名前、メールアドレス、電話番号を正しく入力してください。"
            render :new
            return
        end        

        if @reservation.save
            current_user.update(name: temp_name, email: temp_email, phone_number: temp_phone_number) unless current_user.guest?
            flash[:notice] = '予約が完了しました。'
            redirect_to index_reservation_path 
        else
            flash[:alert] = '予約に失敗しました。もう一度やり直してください。'
            render :new
        end
        
    end

    def confirm
        @reservations = current_user.reservations.where('date >= ?', Date.today)        

        unless @reservations
            flash[:alert] = "予約が見つかりませんでした。"
            redirect_to index_reservation_path and return
        end
        render :confirm
    end

    def destroy
        @reservations = Reservation.find_by_id(params[:id])
        if @reservations
            @reservations.destroy
            redirect_to confirm_reservation_path, notice: '予約をキャンセルしました。'
        end
    end

    private
    def reservation_params
        params.require(:reservation).permit(:date, :time_slot, :adults, :children, :note, :name, :email, :phone_number)
    end
    
end