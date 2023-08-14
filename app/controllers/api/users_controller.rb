module Api
    class UsersController < ApplicationController
      before_action :set_user, only: [:show, :update, :destroy , :followers , :following]
  
      def index
        @users = User.all
        render json: @users
      end
    
      def show

      @user = User.includes(posts: :comments).find(params[:id])
      render json: @user.to_json(include: { posts: { include: :comments } })
      
    
      end

      def followers
       
        @followers =  @user.followers.pluck(:follower_id) 
        @follower_names = []

        @followers.each do |follower_id|
          follower_user = User.find_by(id: follower_id)
          @follower_names <<{ id:follower_user.id , name:follower_user.name , img:follower_user.img } if follower_user
        end
  
        render json: @follower_names
      end
    
      def following
       
        # @following = @user.followings
        @user = User.find(params[:id])

        @following =  @user.followings.pluck(:following_id)
        @following_names = []

        @following.each do |following_id|
          following_user = User.find_by(id: following_id)
          @following_names <<  { id: following_user.id , name: following_user.name ,img: following_user.img } if following_user
        end
  
        render json: @following_names
        # render json: User.find(id: @following)
      end
  
      def create                                            
        @user = User.new(user_params)
  
        if @user.save
          render json: @user, status: :created                
        else
          render json: { errors: @user.errors.full_messages } , status: :unprocessable_entity
        end
      end
  
      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end
  
      def destroy
        @user.destroy
      end
    
      private
                                                              
      def set_user
        @user = User.find(params[:id])                      
      end
  
      def user_params
        params.permit(:name, :email , :password , :img, :fav_topic)      
      end

    end
  end
  