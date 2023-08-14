class Api::LikesController < ApplicationController

    def create
        @posts = Post.find(params[:post_id])
        @posts.update( no_of_likes: @posts[:no_of_likes] +1  )
        render json: @posts 
    end

    


    def likes_params
        params.require(:posts).permit( :post_id )
    end

    
end
