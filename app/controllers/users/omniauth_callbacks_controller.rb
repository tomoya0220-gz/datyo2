class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
        # Facebook 認証のコールバック処理
    end

    def line

    end

    def google_oauth2

    end

    def yahoojp
        auth = request.env['omniauth.auth']

        @user_id = auth.uid

        @name  = auth.info.name
        @email = auth.info.email
        @first_name = auth.info.first_name
        @last_name  = auth.info.last_name

        @token         = auth.credentials.token;
        @refresh_token = auth.credentials.refresh_token;
        @expires_at    = auth.credentials.expires_at;

        render 'users/callback'
    end
end