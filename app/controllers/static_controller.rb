class StaticController < ApplicationController
    include CurrentUserConcern

    def home

        if session[:user_id]
            @current_user = User.find(session[:user_id])
        end

        $all_posts ||= Post.all.sort{|a,b| b.votes.sum(&:value) <=> a.votes.sum(&:value)}

        limit_posts
    end

    def sort
        if session[:user_id]
            @current_user = User.find(session[:user_id])
        end

        if params[:sort_type] == "new"
            $all_posts = Post.all.sort{|a,b| b.updated_at <=> a.updated_at}
        elsif params[:sort_type] == "top"
            $all_posts = Post.all.sort{|a,b| b.votes.sum(&:value) <=> a.votes.sum(&:value)}
        elsif params[:sort_type] == "hot"
            $all_posts = Post.all.sort{ |a,b|

                # a_sec = getSeconds(a.updated_at).to_i
                a_votes = a.votes.sum(&:value).to_i

                # b_sec = getSeconds(b.updated_at).to_i
                b_votes = b.votes.sum(&:value).to_i

                # a_final = a_votes / a_sec
                # b_final = b_votes / b_sec

                # a_final <=>  b_final
            }
        end

        limit_posts
        render "home"
    end

    def getSeconds(date)
        # year = date.strftime("%Y") * 946080000
        month = date.strftime("%m") * 2592000
        day = date.strftime("%d") * 86400
        hour = date.strftime("%H") * 3600
        mins = date.strftime("%M") * 60
        seconds = date.strftime("%S")

        # return month + day + hour + mins + seconds
    end

    def search
        title_results = Post.all.where("title like ?", "%#{params[:search_text]}%")
        url_results = Post.all.where("url like ?", "%#{params[:search_text]}%")

        all_results = title_results + url_results

        if all_results.length == 0
            redirect_to root_path, notice: "no posts matched #{params[:search_text]}"
        else
            $all_posts = all_results
            limit_posts
            render "home"
        end
    end

    def limit_posts

        amount_shown = 10

        param_page = params[:page].to_i
        @final_page = $all_posts.count / amount_shown

        if param_page < 1
            @page = 0
        elsif param_page > @final_page
            @page = @final_page
        else
            @page = param_page
        end

        start_pos = @page * amount_shown
        end_pos = start_pos + amount_shown

        @posts = $all_posts[start_pos...end_pos]
    end
end