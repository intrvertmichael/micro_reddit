class PostsController < ApplicationController

    def create
        post = Post.create(
            title: params["username"].downcase,
            url: params["password"],
            user_id: @current_user.id
        )

        if post
            redirect_to root_path
        else
            render json: { status: 500 }
        end
    end

    def show
    end
end
