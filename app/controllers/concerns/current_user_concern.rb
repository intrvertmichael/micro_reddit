module CurrentUserConcern
    extend ActiveSupport::Concern

    included do
        before_action :set_current_user
    end

    def set_current_user
        puts "-> session:" + session[:user_id].inspect

        if session[:user_id]
            @current_user = User.find(session[:user_id])
        end
    end
end