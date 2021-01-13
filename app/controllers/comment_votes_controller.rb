class CommentVotesController < ApplicationController
    def update
        pid = params[:id]
        cid = params[:comment_id]
        uid = session[:user_id]
        change = params[:change] == "up"? 1 : -1


        if uid
            @vote = CommentVote.find_by(post_id: pid, user_id: uid, comment_id: cid)

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
                CommentVote.create(post_id: pid, user_id: uid, comment_id: cid, value: amount)
            end

            post = Post.find(pid)
            redirect_to post
        end
    end
end
