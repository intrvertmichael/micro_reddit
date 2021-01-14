class StaticController < ApplicationController
    include CurrentUserConcern

    def home
        # newest at top sorting:
        # sorted_list = @posts.sort{|a,b| b.updated_at <=> a.updated_at}

        @posts = Post.all.sort{|a,b| b.votes.sum(&:value) <=> a.votes.sum(&:value)}
    end
end