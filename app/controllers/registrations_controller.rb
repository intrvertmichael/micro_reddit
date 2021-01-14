class RegistrationsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        user = User.create(
            username: params["username"].downcase,
            password: params["password"],
            password_confirmation: params["password_confirmation"],
        )

        if user.valid?
            session[:user_id] = user.id
            redirect_to root_path
        else
            @error_message = user.errors.full_messages
            redirect_to root_path, notice: @error_message
        end
    end
end