class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :check_guest, only: [:show]

    def show
        @user = current_user
    end

    def update
        @user = current_user
        if @user.update(user_params)
            redirect_to index_reservation_path(@user), notice: 'ユーザー情報を更新しました'
        else
            render :show
        end
    end

    private
    def check_guest
        if current_user.email == 'guest@example.com' 
            redirect_to index_reservation_path, alert: "ゲストユーザーはこのページにアクセスできません。"
        end
    end

    def user_params
        params.require(:user).permit(:name, :email, :phone_number)
    end


end