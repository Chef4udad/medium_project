class Api::CreditionalsController < ApplicationController

    
    def index 

    end

    def create 
        user = User.find_by( email: params[:email] , password: params[:password])
        if user 
            session[:user_id] = user.id
            redirect_to dashboard_path, notice: 'Logged in successfully'
        else

            # flash.now[:error] = 'Invalid email or password'
        end

    end 
    private

    def user_params
      params.permit( :email , :password )
    end

end
