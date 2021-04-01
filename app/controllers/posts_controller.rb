class PostsController < ApplicationController
    before_action :require_user_login, only: [:new, :create, :update, :edit, :destroy]
    before_action :get_school
    before_action :get_user
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    def index
        @posts = Post.all.reverse
    end

    def show
        
    end

    def new
        @post = @school.posts.new
        
    end

    def create
        @post = @school.posts.new(post_params)
        @post.user_id = current_user.id
        @post.school_id = @school.id
        
        if @post.save
            current_user.subject_id = @post.subject_id
            flash[:message] = "Added your post."
            redirect_to post_path(@post)
        else
            flash[:message] = "Your post could not be added."
            render 'new'
        end
    end

    def edit
    end

    def update
        if @post.update(post_params)
            redirect_to post_path(@post)
        end
    end

    def destroy
        @post.destroy
        flash[:message] = "Post deleted."
        redirect_to school_path(@user.school)
    end


    private

    def get_school
        @school = School.find_by_id(params[:school_id])
    end

    def get_user
        @user = current_user
    end

    def set_post
        # binding.pry
        @post = Post.find_by_id(params[:id])
        # binding.pry
        if !@post
            flash[:message] = "Post does not exitst."
            redirect_to '/' if !@post
        end
    end

    def post_params
        params.require(:post).permit(:title, :content, :subject_id, :public, :user_id)
    end 


end
