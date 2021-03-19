class FakeUsersController < ApplicationController
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
            redirect_to user_path(@user)
        else
            @errors = @user.errors.full_messages
            render 'new'
        end
    end

    ########## EDIT ACCOUNT ##############

    def edit
    end

    def update
        @user.update(user_params(:current_school))
    end

    ######### DELETE ACCOUNT #############


    def destroy
        @user.destroy
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password, :current_school, :school_id)
    end 

    def set_user
        @user = User.find_by_id(params[:id])
        redirect_to '/' if !@user
    end

    def find_school_or_create
        school = School.find_or_create_by(name: @user.current_school)
    end
end
