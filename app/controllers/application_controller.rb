class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    
    private
    def current_account
        rodauth.rails_account
    end
end
