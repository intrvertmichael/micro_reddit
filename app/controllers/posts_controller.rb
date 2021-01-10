class PostsController < ApplicationController

    def create
        post = Post.create(
            user_id: session[:user_id],
            title: params["title"],
            url: params["url"]
        )

        if post
            redirect_to root_path
        else
            render json: { status: 500 }
        end
    end

    def show
        @post = Post.find(params[:id])
    end
end
