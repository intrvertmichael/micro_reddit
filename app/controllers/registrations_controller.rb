class RegistrationsController < ApplicationController
    def create
        user = User.create!(
            username: params["username"].downcase!,
            password: params["password"],
            password_confirmation: params["password_confirmation"],
        )

        if user
            session[:user_id] = user.id

            # render json: { status: :created, user: user }
            redirect_to root_path
        else
            render json: { status: 500 }
        end

    end
end