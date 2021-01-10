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

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])

        if @post.update(
            title: params["post"]["title"],
            url: params["post"]["url"]
        )
            redirect_to @post
        else
            render json: { status: 500 }
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        redirect_to root_path
    end
end
