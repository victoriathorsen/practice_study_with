module ApplicationHelper

    def current_user
        User.find_by(id: session[:user_id])
    end

    def logged_in?
        !!current_user
    end

    def require_user_login
        unless logged_in?
            redirect_to new_user_path
        end
    end

    def current_submission
        @post = Post.find_by(id: params[:post_id])
    end

    def attends_school
        School.find(params[:name])
    end
end
