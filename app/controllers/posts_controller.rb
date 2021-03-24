class PostsController < ApplicationController
    before_action :require_user_login, only: [:new, :create, :update, :edit, :destroy]
    before_action :get_school, except: [:show]
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    def index
        @posts = Post.all.reverse
    end

    def show
        
    end

    def new
        # binding.pry
        @post = @school.posts.new
    end

    def create
        @post = @school.posts.build(post_params)
        @post.user_id = current_user.id
        @post.school_id = @school.id
        if @post.save
            flash[:message] = "Added your post."
            redirect_to post_path(@post)
        else
            flash[:message] = "Your post could not be added."
            render 'new'
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

        redirect_to school_path(@school)
    end


    private

    def set_post
        @post = Post.find_by_id(params[:id])
        if !@post
            flash[:message] = "Post does not exitst."
            redirect_to '/' if !@post
        end

    end

    def get_school
        @school = School.find_by_id(params[:school_id])
    end

    def post_params
        params.require(:post).permit(:title, :content, :comment_id)
    end 


end
