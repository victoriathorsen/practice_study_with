class PostsController < ApplicationController
    before_action :require_user_login
    before_action :get_school
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    def index
        @posts = @school.posts.all
    end

    def show
    end

    def new
        @post = @school.posts.new
    end

    def create
        @post = @school.posts.new(post_params)
        @post.user_id = current_user.id
        # @post.submission_id = current_post.id
        if @post.save
            redirect_to school_path(school)
        else
            redirect_to school_path(@school)
        end
    end

    def update
        @school.posts.update(post_params)

        redirect_to school_post_path(@post)
    end

    def edit
    end

    def destroy
        @school.post.destroy

        redirect_to schools_path
    end

    private

    def get_school
        @school = School.find(params[:school_id])
    end

    def set_post
        @post = @school.posts.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:title, :content)
    end 

    def logged_in?
        !!current_user
    end

    def require_user_login
        unless logged_in?
            redirect_to login_path
        end
    end

    def current_user
        User.find_by(id: session[:user_id])
    end

end
