class ReservationsController < ApplicationController
    before_action :authenticate_user!
    before_action :validate_max_people_per_time_slot, only: [:create]
    before_action :total_people_count_within_limit, only: [:create]
    before_action :ensure_authenticated_user!, only: [:confirm]

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
        end_time = (Time.parse(params[:time_slot]) + 2.hours).strftime("%H:%M")
        total_reserved = Reservation.total_reservations_for_time_range(params[:time_slot], end_time)
        @remaining_seats = 20 - total_reserved
    end

    def create
        @reservation = Reservation.new(date: params[:date], time_slot: params[:time_slot], adults: params[:reservation][:adults], children: params[:reservation][:children], note: params[:reservation][:note])
        temp_name = params[:reservation][:name]
        temp_email = params[:reservation][:email]
        temp_phone_number = params[:reservation][:phone_number]
        @reservation.user = current_user
        
        if current_user.guest? && (temp_name.blank? || temp_email.blank? || temp_phone_number.blank?)
            flash[:alert] = "名前、メールアドレス、電話番号を正しく入力してください。"
            render :new
            return
        end

        unless total_people_count_within_limit
            flash[:alert] = @reservation_error
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
        unless @reservations.exists?
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

    def validate_max_people_per_time_slot
        existing_reservations = Reservation.where(date: params[:date], time_slot: params[:time_slot])
        total_people_existing = existing_reservations.sum(:adults) + existing_reservations.sum(:children)
        total_people_new = params[:reservation][:adults].to_i + params[:reservation][:children].to_i
        
        if total_people_existing + total_people_new > 20
            flash[:alert] = 'この時間帯の予約は20人までです。'
            redirect_to new_reservation_path
        end
    end

    def total_people_count_within_limit
        total_adults_already_reserved = Reservation.where(date: params[:reservation][:date], time_slot: params[:reservation][:time_slot]).sum(:adults)
        total_children_already_reserved = Reservation.where(date: params[:reservation][:date], time_slot: params[:reservation][:time_slot]).sum(:children)   
        total_people_already_reserved = total_adults_already_reserved + total_children_already_reserved
        total_people_for_new_reservation = params[:reservation][:adults].to_i + params[:reservation][:children].to_i
        
        if total_people_already_reserved + total_people_for_new_reservation > 20
            @reservation_error = "総数が20人を超えています。人数を減らしてください。"
            false
        else
            true
        end
    end
    
    def ensure_authenticated_user!
        if current_user&.guest?
            redirect_to index_reservation_path, alert: 'ゲストユーザーはこのページにアクセスできません。'
        end
    end

end