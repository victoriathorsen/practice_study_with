class SessionsController < ApplicationController
    def home
    end

    def destroy
        session.clear
        redirect_to root_path
    end

    def create
        user = User.find_by(username: params[:users][:username])
        if user && user.authenticate(params[:users][:password])
            session[:user_id] = user.id
            flash[:message] = "Welcome %{username}!"
            redirect_to root_path
        elsif
            params[:users][:username] == "" || params[:users][:password] == ""
            flash[:message] = "No fields can be left blank"
            redirect_to login_path
        else
            flash[:message] = "Username or password is invalid."
            redirect_to login_path
        end
    end

end
