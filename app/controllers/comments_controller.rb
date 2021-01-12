class CommentsController < ApplicationController
    def create
        @post = Post.find(params["post_id"])

        if session[:user_id]
            comment = Comment.create(post_id: params["post_id"], user_id: session[:user_id], body: params["body"])

        end

        redirect_to @post
    end

    def edit
        @comment = Comment.find(params[:comment_id])
        @post = Post.find(@comment.post_id)
    end

    def update
        @comment = Comment.find(params[:id])
        @comment.update(
            post_id: params[:comment]["post_id"],
            user_id: session[:user_id],
            body: params[:comment]["body"]
        )

        @post = Post.find(params[:comment][:post_id].to_i)
        redirect_to @post
    end

    def destroy
        @comment = Comment.find(params[:comment_id])

        if belongs_to_user
            @comment.destroy
        end

        @post = Post.find(@comment.post_id)
        redirect_to @post
    end

    def belongs_to_user
        return (session[:user_id] == @comment.user_id.to_s)
    end
end