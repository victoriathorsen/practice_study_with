class SubjectsController < ApplicationController
    before_action :set_subject, only: [:show]
    def index
        @subjects = Subject.alpha
        @subjects = Subject.search(params[:search])
    end

    def show
        
    end

    private 

    def set_subject
        @subject = Subject.find_by_id(params[:id])
        if !@subject
            flash[:message] = "Subject does not exitst."
            redirect_to subjects_path if !@subject
        end
    end

end
