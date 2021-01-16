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
        elsif params[:sort_type] == "hot"
            $all_posts = Post.all.sort{|a,b| b.votes.sum(&:value) <=> a.votes.sum(&:value)}
        elsif params[:sort_type] == "top"
            $all_posts = Post.all.sort{ |a,b|
                b.votes.sum(&:value) <=> a.votes.sum(&:value)
            }
        end

        limit_posts
        render "home"
    end

    def search
        puts params["search_text"]
        puts "-> searching ..."

        # x= Post.all.where("title like ?", "%#{params[:search_text]}%")
        # puts x.inspect

        x = Post.all.where("title like ?", "%#{params[:search_text]}%")

        if x.length == 0
            x = Post.all.where("url like ?", "%#{params[:search_text]}%")
        end

        if x.length == 0
            redirect_to root_path, notice: "no posts matched #{params[:search_text]}"
        else
            $all_posts = x
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