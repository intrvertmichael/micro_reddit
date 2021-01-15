class PostsController < ApplicationController

    def create
        post = Post.create(
            user_id: session[:user_id],
            title: params["title"],
            url: params["url"]
        )

        if post.valid?
            redirect_to root_path
        else
            @error_message = post.errors.full_messages
            redirect_to root_path, notice: @error_message
        end
    end

    def show
        @post = Post.find(params[:id])

        @comments = @post.comments.sort{|a,b| b.comment_votes.sum(&:value) <=> a.comment_votes.sum(&:value)}

        if session[:user_id]
            @current_user = User.find(session[:user_id])
        end
    end

    def edit
        if belongs_to_user
            @post = Post.find(params[:id])
        else
            redirect_to root_path
        end
    end

    def update
        if belongs_to_user
            @post = Post.find(params[:id])

            if @post.update(
                title: params["post"]["title"],
                url: params["post"]["url"]
            )
                redirect_to @post
            else
                render json: { status: 500 }
            end
        else
            redirect_to root_path
        end
    end

    def destroy
        if belongs_to_user
            @post = Post.find(params[:id])
            Vote.where(post_id: params[:id]).delete_all
            Comment.where(post_id: params[:id]).delete_all
            @post.destroy
        end

        redirect_to root_path
    end

    def belongs_to_user
        @post = Post.find(params[:id])
        return (session[:user_id] == @post.user.id.to_s)
    end

    def sort
        @post = Post.find(params[:id])
        if params[:sort_type] == "new"
            @comments = @post.comments.sort{|a,b| b.updated_at <=> a.updated_at}
        elsif params[:sort_type] == "hot"
            @comments = @post.comments.sort{|a,b| b.comment_votes.sum(&:value) <=> a.comment_votes.sum(&:value)}
        end
        render "show"
    end
end
