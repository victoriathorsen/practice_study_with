class SchoolsController < ApplicationController
    before_action :set_school, only: [:show]

    def index
        @schools = School.alpha
        @schools = School.search(params[:search])
    end

    def show
        @posts = @school.posts
    end

    def new
        @school = School.new
    end

    def create
        @school= School.find_by(name: params[:school][:name])
        if @school.save
            redirect_to schools_path(@school)
        else
            @errors = @school.errors.full_message
            render 'new'
        end
    end


    private
    

    def set_school
        @school = School.find_by_id(params[:id])
        if !@school
            flash[:message] = "School does not exitst."
            redirect_to schools_path if !@school
        end
    end
        
end

    def school_params
        params.require(:school).permit(:name, :id)
    end 