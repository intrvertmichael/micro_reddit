class CommentVotesController < ApplicationController
    def update
        cid = params[:comment_id]
        uid = session[:user_id]
        change = params[:change] == "up"? 1 : -1

        if uid
            @vote = CommentVote.find_by(user_id: uid, comment_id: cid)

            if @vote
                if @vote.value == change
                    @vote.value = 0
                    @vote.save
                else
                    @vote.value = change
                    @vote.save
                end
            else
                @vote = CommentVote.create(user_id: uid, comment_id: cid, value: change)
            end

            @post = Post.find(@vote.comment.post.id)
            redirect_to @post
        end
    end
end
