class SessionsController < ApplicationController
 
    def destroy
        session.clear
        redirect_to root_path
    end

    def create
        user = User.find_by(username: params[:users][:username])
        if user && user.authenticate(params[:users][:password])
            session[:user_id] = user.id
            flash[:message] = "Welcome #{user.username}!"
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

    def omniauth
        @user = User.find_or_create_by(provider: auth['provider'])
            @user.username = auth["info"]["name"]
            @user.email = auth["info"]["email"]
            @user.password = SecureRandom.hex(8)
        if @user.save
            session[:user_id] = @user.id
            flash[:message] = "Welcome #{@user.username}!"
            redirect_to user_path(@user)
        else
            flash[:message] = "Something went wrong!"
            redirect_to root_path
        end
    end

    # def omniauth
    #     @user = User.find_by(id: auth['uid']) 
    #     if @user != nil
    #         session[:user_id] = @user.id
    #         flash[:message] = "Welcome #{@user.email}!"
    #         redirect_to root_path
    #     elsif
    #         @user = User.new(id: auth['uid'])
    #         binding.pry
    #         @user.username= auth["info"]["email"]
    #         @user.password= SecureRandom.hex(8)
    #         if @user.save
    #             session[:user_id] = @user.id
    #             flash[:message] = "Welcome #{@user.email}!"
    #             redirect_to root_path
    #         end
    #     else
    #         flash[:message] = " Could not create an account."
    #         redirect_to root_path
    #     end
    # end

    private
    
    def auth
        request.env['omniauth.auth']
    end

end
