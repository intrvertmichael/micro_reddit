class SessionsController < ApplicationController
    include CurrentUserConcern

    def create
        user = User
                .find_by(username: params["username"].downcase)
                .try(:authenticate, params["password"])

        if user
            session[:user_id] = user.id
            redirect_to root_path
        else
            # render json: { status: 401 }
            redirect_to root_path, notice: ["Log In Failed"]
        end
    end

    def logout
        puts "logout"
        reset_session
        redirect_to root_path
    end

end