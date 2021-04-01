class CommentsController < ApplicationController
    before_action :get_post
    before_action :get_user, only: [:show]
    before_action :set_comment, only: [:show, :destroy]

    def new
        @comment = @post.comments.new
    end

    def create
        @comment = @post.comments.new(comment_params)
        @comment.user_id = current_user.id
        @comment.post_id = @post.id
        if @comment.save
            flash[:message] = "Added your comment."
            @post_comments = @comment
            redirect_to post_path(@post)
        else
            flash[:message] = "Your comment could not be added."
            redirect_to posts_path
        end
    end

    def destroy
        @post.comment.destroy

        redirect_to post_path(@post)
    end

    private

    def get_post
        @post = Post.find(params[:post_id])
    end

    def get_user
        @user = User.find_by_id(params[:id])
    end

    def set_comment
        @comment = @post.comments.find_by_id(params[:id])
        redirect_to '/' if !@comment
    end

    def get_comments_in_post
        @comments = @post.comments.all
    end

    def comment_params
        params.require(:comment).permit(:content)
    end 

end