class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?

        private

        def current_user
            @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
        end

        def logged_in?
            !!current_user
        end

        def require_user_login
            unless logged_in?
                redirect_to login_path
            end
        end

        def current_post
            @post = Post.find_by(id: params[:post_id])
        end

        def attends_school
            School.find(params[:name])
        end

end
