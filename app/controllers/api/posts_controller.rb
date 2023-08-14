module Api
    class PostsController < ApplicationController
      before_action :authenticate
      before_action :set_post, only: [:show, :update, :destroy, :revisions]
  
      def index
        
        @posts = Post.all

        if params[:author]
          @posts = @posts.where(author: params[:author])
        end

        if params[:title]
          @posts = @posts.where(title: params[:title])
        end

        if params[:category]
          @posts = @posts.where(category: params[:category])
        end
  
        if params[:start_date]
          start_date = Date.parse(params[:start_date])
          @posts = @posts.where('created_at >= ?', start_date.beginning_of_day)
        end
  
        if params[:end_date]
          end_date = Date.parse(params[:end_date])
          @posts = @posts.where('created_at <= ?', end_date.end_of_day)
        end

      
      @posts = @posts.includes(:comments) 
      @posts = @posts.to_json(include: :comments)


        render json: @posts

      end

      def top_posts
        @top_posts = Post.order(no_of_likes: :desc).limit(5)

        render json: @top_posts, status: :ok
      end

      def recommended_posts
        user = authenticate
        interested_topics = user.fav_topic
        @recommended_posts = Post.where(title: interested_topics)
        render json: @recommended_posts, status: :ok
      end

      def drafts
        @drafts = authenticate.posts.where(draft: true)
        render json: @drafts
      end

      def save_for_later
        @post = Post.find(params[:id])
        @user.saved_posts << @post
      
        render json: @post, status: :ok
      end

      def saved_posts
        @user = authenticate
        @saved_posts = @user.saved_posts
      
        render json: @saved_posts, status: :ok
      end
      
      def show
        @posts = Post.includes(:comments).find(params[:id])
        @reading_time = calculate_reading_time(@post.title)

        render json: {
          post: @posts.to_json(include: :comments),
          reading_time: @reading_time
        }
      end
    
      def create
        @post = Post.new(post_params)
        @post.author = @user.id
        if @post.save
          add_post_to_list(params[:list_id], @post.id) if params[:list_id]
          render json: @post, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end
                                                            
      def update
        @post = Post.find(params[:id])
        create_post_revision(@post)

        if @post.update(post_params)
          update_list_with_post(params[:list_id], @post.id) if params[:list_id]
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end
  
      
      def revisions
        @revisions = @post.post_revisions.order(edited_at: :desc)
        render json: @revisions
      end


      def destroy
        @post.destroy
        head :no_content
      end
  
      private

      def create_post_revision(post)
        PostRevision.create!(
          post: post,
          title: post.title,
          category: post.category,
          edited_at: Time.now
        )
      end

      def calculate_reading_time(content)
        words_per_minute = 200
        word_count = content.split.size
        reading_time_minutes = (word_count.to_f / words_per_minute).ceil
      end

      def add_post_to_list(list_id, post_id)
        @list = @user.lists.find(list_id)
        @post = Post.find(post_id)
        @list.posts << @post
      end
  
      def update_list_with_post(list_id, post_id)
        @list = @user.lists.find(list_id)
        @post = Post.find(post_id)
        @list.posts.delete(@post) 
        @list.posts << @post
      end
  
      def filter_by_author(posts, author)
        posts.where(author: author)
      end
  
      def filter_by_date(posts, start_date, end_date)
        posts.where(created_at: start_date..end_date)
      end

      def set_post
        @post = Post.find(params[:id])
      end
  
      def post_params
        params.permit(:author, :img , :title, :no_of_likes, :category, :draft, :content)
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
  