class CommentVotesController < ApplicationController
    def update
        cid = params[:comment_id]
        uid = session[:user_id]
        change = params[:change] == "up"? 1 : -1

        if uid
            set_comment_vote(uid, cid, change)
            @post = Post.find(@vote.comment.post.id)
            redirect_to @post
        end
    end

    def ajax_update
        cid = params[:comment_id]
        uid = session[:user_id]
        change = params[:value] == "up"? 1 : -1

        if uid
            set_comment_vote(cid, uid, change)
            comment = Comment.find(cid)

            render json: { vote: @comment_vote, points: comment.points }
        end
    end

    def set_comment_vote(cid, uid, change)
        @comment_vote = CommentVote.find_by(user_id: uid, comment_id: cid)

        if @comment_vote
            if @comment_vote.value == change
                @comment_vote.value = 0
                @comment_vote.save
            else
                @comment_vote.value = change
                @comment_vote.save
            end
        else
            @comment_vote = CommentVote.create(user_id: uid, comment_id: cid, value: change)
        end
    end
end
