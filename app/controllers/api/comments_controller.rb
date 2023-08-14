module Api
    class CommentsController < ApplicationController
      before_action :authenticate
      before_action :set_comment, only: [:show, :update, :destroy]
  
      def index
        @comments = Comment.all
        render json: @comments
      end
  
      def show
        render json: @comment
      end
  
      def create
        @comment = Comment.new(comment_params)
        @comment.user_id = @user.id
        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end
  
      def update
        if @comment.update(comment_params)
          render json: @comment
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end
  
      def destroy
        @comment.destroy
        head :no_content
      end

      def comments_for_post
        @post = Post.find(params[:post_id])
        @comments = @post.comments
        render json: @comments
      end
  
      private
  
      def set_comment
        @comment = Comment.find(params[:id])
      end
  
      def comment_params
        params.permit(:user_id, :post_id, :text)
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
  