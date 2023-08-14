module Api
    class PaymentsController < ApplicationController
      before_action :authenticate 
  
      def create_order
        amount = params[:amount]
        currency = 'INR'
        order = Razorpay::Order.create(amount: amount, currency: currency)
  
        render json: { order_id: order.id, amount: amount }
      end
  
      def webhook
        payload = request.body.read
        signature = request.headers['x-razorpay-signature']
  
        begin
          Razorpay::Utility.verify_webhook_signature(payload, signature, 'your_webhook_secret')
          event = JSON.parse(payload)
          
         
          
          head :ok
        rescue Razorpay::Error::SignatureVerificationError
          head :bad_request
        end
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
  