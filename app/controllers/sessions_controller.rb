class SessionsController < ApplicationController
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