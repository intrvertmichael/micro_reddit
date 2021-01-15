class UsersController < ApplicationController
    def show
        if params[:author_id]
            user = params[:author_id]
        else
            user = session[:user_id]
        end

        @author = User.find(user)

        posts = Post.where(user_id: user).all

        total = 0

        posts.map { |n|
            post = Post.find(n.id)
            total += post.points
        }

        @karma = total
    end
end
