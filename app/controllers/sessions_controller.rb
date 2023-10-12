class SessionsController < ApplicationController
    def create
        auth = request.env["omniauth.auth"]
        # authからユーザー情報を取得して、セッションやデータベースに保存
        redirect_to new_reservation_path
    end
end