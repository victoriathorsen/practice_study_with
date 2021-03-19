class SchoolsController < ApplicationController
    before_action :set_school, only: [:show, :destroy]

    def index
        @schools = School.all
    end

    def show
    end

    def new
        @school = School.new
    end

    def create
        @school = School.new(school_params)
        # binding.pry
        if @school.save
            redirect_to schools_path(@school)
        else
            # @error = school.errors.full_message
            render 'new'
        end
    end

    def destroy
        @school.destroy

        # redirect_to posts_path
    end

    private

    def school_params
        params.require(:school).permit(:name)
    end 

    def set_school
        @school = School.find_by_id(params[:id])
        redirect_to '/' if !@school
    end
end


# def set_school
#     @school = School.find_by_id(params[:id]) || @user.school_id = School.find_by_id(params[:id])
#     redirect_to '/' if !@user.school_id || !@school
# end