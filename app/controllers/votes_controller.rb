class VotesController < ApplicationController
    def update
        pid = params[:id]
        uid = session[:user_id]
        change = params[:change] == "up"? 1 : -1

        if uid
            set_vote(pid, uid, change)
            redirect_to root_path
        end
    end

    def ajax_update
        pid = params[:post_id]
        uid = session[:user_id]
        value = params[:value] == "up"? 1 : -1

        if uid
            set_vote(pid, uid, value)

            post = Post.find(pid)
            render json: {vote: @vote, points: post.points }
        else
            render json: { error: "Log In or Register to Vote on a Post" }
        end
    end


    def set_vote(pid, uid, value)
        @vote = Vote.find_by(post_id: pid, user_id:uid)

        if @vote
            puts "there is a vote"
            if @vote.value == value
                @vote.value = 0
                @vote.save
            else
                @vote.value = value
                @vote.save
            end
        else

            @vote = Vote.create(user_id: uid, post_id: pid, value: value)
        end
    end
end