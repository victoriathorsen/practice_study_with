class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def show
    end
    ############ SIGN UP #################
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        @school = find_school_or_create
        @user.current_school == @school.name
        @user.school_id = @school.id
        if @user.save
            #log them in
            session[:user_id] = @user.id
            flash[:message] = "Welcome #{@user.username}!"
            redirect_to root_path
        else
            @error = @user.errors.full_messages
            render 'new'
        end
    end

    ########## EDIT ACCOUNT ##############

    def edit
    end

    def update
        if @user.update!(user_params(:username, :current_school))
            @user.current.school 
            flash[:message] = "Updated account."
            redirect_to user_path(@user)
        else
            flash[:message] = "Could not update account."
            render 'edit'
        end
    end

    ######### DELETE ACCOUNT #############


    def destroy
        @user.destroy
    end

    private

    def user_params(*args)
        params.require(:user).permit(*args)
    end 

    def set_user
        @user = User.find_by_id(params[:id])
        redirect_to '/' if !@user
    end

    def find_school_or_create
        school = School.find_or_create_by(name: @user.current_school)
    end
end
