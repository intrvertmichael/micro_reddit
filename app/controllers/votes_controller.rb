class VotesController < ApplicationController
    def update
        pid = params[:id]
        uid = session[:user_id]
        change = params[:change] == "up"? 1 : -1


        if uid
            @vote = Vote.find_by(post_id: pid, user_id:uid)

            if @vote
                if @vote.value == change
                    @vote.value = 0
                    @vote.save
                else
                    @vote.value = change
                    @vote.save
                end
            else
                amount = params[:change] == "up"? 1 : -1
                Vote.create(user_id: uid, post_id: pid, value: amount)
            end

            redirect_to root_path
        end
    end
end