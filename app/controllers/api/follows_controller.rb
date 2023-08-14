# app/controllers/api/follows_controller.rb
module Api
    class FollowsController < ApplicationController
      before_action :set_follow, only: [:destroy]
  

      def index
        @follow = Follow.all

        if params[:follower_id]
          @follow = @follow.where(follower_id: params[:follower_id])
        end

        if params[:following_id]
          @follow = @follow.where(following_id: params[:following_id])
        end

        render json: @follow
      end
    
      def create
        @follow = Follow.new(follow_params)
  
        if @follow.save
          render json: @follow, status: :created
        else
          render json: @follow.errors, status: :unprocessable_entity
        end
      end
  
     
      def destroy
        @follow.destroy
        head :no_content
      end
  
      private
  
      def set_follow
        @follow = Follow.find(params[:id])
      end
  
      def follow_params
        params.permit(:follower_id, :following_id)
      end
    end
  end
  