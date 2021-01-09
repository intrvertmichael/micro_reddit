class StaticController < ApplicationController
    include CurrentUserConcern

    def home
        # render json: { status: "It's working" }
    end
end