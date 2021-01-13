class UsersController < ApplicationController
    def show
        if params[:author_id]
            @author = User.find(params[:author_id])
        else
            @author = User.find(session[:user_id])
        end
    end
end
