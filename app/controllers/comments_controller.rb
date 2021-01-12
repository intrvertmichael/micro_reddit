class CommentsController < ApplicationController
    def create
        @post = Post.find(params["post_id"])

        if session[:user_id]
            comment = Comment.create(post_id: params["post_id"], user_id: session[:user_id], body: params["body"])

        end

        redirect_to @post

    end
end