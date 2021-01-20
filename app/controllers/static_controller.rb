class StaticController < ApplicationController
    include CurrentUserConcern

    def home

        if session[:user_id]
            @current_user = User.find(session[:user_id])
        end

        if $sort_type == "new"
            all_posts = Post.all.sort{|a,b| b.updated_at <=> a.updated_at}
        elsif $sort_type == "hot"
            all_posts = Post.all.sort{ |a,b|

                a_sec = Time.now - a.updated_at
                a_votes = a.votes.sum(&:value).to_i

                b_sec = Time.now - b.updated_at
                b_votes = b.votes.sum(&:value).to_i

                a_final = a_votes / a_sec
                b_final = b_votes / b_sec

                b_final <=>  a_final
            }
        else
            all_posts = Post.all.sort{|a,b| b.votes.sum(&:value) <=> a.votes.sum(&:value)}
        end

        limit_posts(all_posts)
    end

    def sort
        if session[:user_id]
            @current_user = User.find(session[:user_id])
        end

        $sort_type = params[:sort_type]
        redirect_to root_path
    end

    def search
        title_results = Post.all.where("title like ?", "%#{params[:search_text]}%")
        url_results = Post.all.where("url like ?", "%#{params[:search_text]}%")

        all_results = title_results + url_results

        if all_results.length == 0
            redirect_to root_path, notice: "no posts matched #{params[:search_text]}"
        else
            limit_posts(all_results)
            render "home"
        end
    end

    def limit_posts(all_posts)

        amount_shown = 25

        param_page = params[:page].to_i
        @final_page = all_posts.count / amount_shown

        if param_page < 1
            @page = 0
        elsif param_page > @final_page
            @page = @final_page
        else
            @page = param_page
        end

        start_pos = @page * amount_shown
        end_pos = start_pos + amount_shown

        @posts = all_posts[start_pos...end_pos]
        @shifter = 1 + params[:page].to_i * amount_shown
    end
end