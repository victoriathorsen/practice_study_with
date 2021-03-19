module UsersHelper

    def find_school
        School.find_by(name: params[:name])
    end

end
