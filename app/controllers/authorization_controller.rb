require 'jwt'
class AuthorizationController < ApplicationController

  def create

    user = User.find_by(email: params[:email])

    if user && user.password == params[:password]
        
      payload = {
        author: user.id,
        exp: 24.hours.from_now.to_i
      }

      token = JWT.encode(payload, 'ASDFGH', 'HS256')
      render json: { token: token }


    else
      render json: { error: "Invali details of user" }, status: :unauthorized

    end
  end
  
end
  