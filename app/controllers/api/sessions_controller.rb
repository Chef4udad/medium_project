module Api
    class SessionsController < ApplicationController
      def create
        user = User.find_by(email: params[:email], password: params[:password])
  
        if user
                  #   session[:user_id] = user.id
          render json: { message: 'Logged in successfully' }, status: :ok
        else
          
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end
  
      def destroy
        session.delete(:user_id)
        render json: { message: 'Logged out successfully' }
      end
      
    end
  end
  