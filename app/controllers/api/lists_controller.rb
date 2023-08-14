module Api
    class ListsController < ApplicationController
      before_action :authenticate
      before_action :set_list, only: [:show, :add_post, :share]
  
      def index
        @lists = @user.lists.includes(:posts)
        render json: @lists.to_json(include: :posts)
      end
  
      def show
        render json: @list.to_json(include: :posts)
      end
  
      def create
        @list = @user.lists.new(list_params)
  
        if @list.save
          render json: @list, status: :created
        else
          render json: @list.errors, status: :unprocessable_entity
        end
      end
  
      def add_post
        @post = Post.find(params[:post_id])
        @list.posts << @post
        render json: @list.to_json(include: :posts)
      end
  
      def share
        @list = List.find(params[:id])
        user_to_share_with = User.find(params[:user_id]) 
        @list.shared_users << user_to_share_with
        render json: @list, status: :ok
      end
  
      private
  
      def set_list
        @list = @user.lists.find(params[:id])
      end
  
      def list_params
        params.require(:list).permit(:title, :user_id)
      end

      def authenticate

        key = request.headers['Authorization']
        token = key.split(' ').last if key 
    
        begin
          decoded_token = JWT.decode(token, 'ASDFGH', true, algorithm: 'HS256')
          render json: {error: "Your token is invalid"} if !decoded_token[0]['author']
          @user = User.find(decoded_token[0]['author'])
        rescue JWT::DecodeError
          render json: { error: "Unauthorized user" }, status: :unauthorized
        end
    end

    end
  end
