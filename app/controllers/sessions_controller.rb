class SessionsController < ApplicationController
    include CurrentUserConcern

    def create
        user = User
                .find_by(username: params["username"].downcase)
                .try(:authenticate, params["password"])

        if user
            session[:user_id] = user.id.to_s

            # render json: {
            #     logged_in: true,
            #     user: user,
            #     session_user_id: session[:user_id]
            # }

            redirect_to root_path
        else
            render json: { status: 401 }
        end
    end

    def logged_in
        if @current_user
            render json: {
                logged_in: true,
                user: @current_user
            }
        else
            render json: {
                logged_in: false
            }
        end
    end

    def logout
        puts "logout"
        reset_session
        # render json: { status: 200, logged_out: true }
        redirect_to root_path
    end

end