class StaticController < ApplicationController
    include CurrentUserConcern

    def home
        # render json: { status: "It's working" }
        @posts = Post.all
    end
end