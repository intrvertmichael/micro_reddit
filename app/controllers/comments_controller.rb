class CommentsController < ApplicationController
    def create
        @post = Post.find(params["post_id"])

        if session[:user_id]
            comment = Comment.create(post_id: params["post_id"], user_id: session[:user_id], body: params["body"])

            if comment.valid?
                redirect_to @post
            else
                @error_message = comment.errors.full_messages
                redirect_to @post, notice: @error_message
            end
        end
    end

    def edit
        @comment = Comment.find(params[:comment_id])
        @post = Post.find(@comment.post_id)
    end

    def update
        @comment = Comment.find(params[:id])

        if belongs_to_user
            @comment.update(
                post_id: params[:comment]["post_id"],
                user_id: session[:user_id],
                body: params[:comment]["body"]
            )
        end

        @post = Post.find(params[:comment][:post_id].to_i)
        redirect_to @post
    end

    def destroy
        @comment = Comment.find(params[:comment_id])
        post_id = @comment.post_id

        if belongs_to_user
            @comment.destroy
        end

        @post = Post.find(post_id)
        redirect_to @post
    end

    def belongs_to_user
        x = session[:user_id] == @comment.user_id
        return x
    end
end