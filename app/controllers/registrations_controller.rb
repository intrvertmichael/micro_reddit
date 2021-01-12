class RegistrationsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        user = User.create!(
            username: params["username"].downcase,
            password: params["password"],
            password_confirmation: params["password_confirmation"],
        )

        if user
            session[:user_id] = user.id
            redirect_to root_path
        else
            render json: { status: 500 }
        end
    end
end