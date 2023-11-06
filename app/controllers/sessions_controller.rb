class SessionsController < ApplicationController
    def new
        # 一意のstateトークンを生成
        random_uid = SecureRandom.hex(10) 
        session[:random_uid] = random_uid

        # LINEログイン用のURLを構築
        query = {
            response_type: 'code',
            client_id: ENV['LINE_KEY'], 
            redirect_uri: 'https://localhost:8080/auth/line/callback', 
            state: random_uid,
            scope: 'profile'
        }.to_query

        url = "https://access.line.me/oauth2/v2.1/authorize?#{query}"
        redirect_to url # またはこのURLをビューで使ってリンクを提供する
    end
    
    def create
        auth = request.env["omniauth.auth"]                
        user = User.find_or_create_by(user_id: auth["uid"]) do |u|
        u.name = auth["info"]["name"]
        u.email = auth["info"]["email"]
        
        end

        # セッションを作成
        session[:user_id] = user.id

        redirect_to index_reservation_path, notice: "ログインしました"
        
    end
    
end