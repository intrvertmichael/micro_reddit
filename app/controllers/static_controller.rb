class StaticController < ApplicationController
    include CurrentUserConcern

    def home
        @posts = Post.all.sort{|a,b| b.votes.sum(&:value) <=> a.votes.sum(&:value)}
    end

    def sort
        if params[:sort_type] == "new"
            @posts = Post.all.sort{|a,b| b.updated_at <=> a.updated_at}
        elsif params[:sort_type] == "hot"
            @posts = Post.all.sort{|a,b| b.votes.sum(&:value) <=> a.votes.sum(&:value)}
        end
        render "home"
    end
end