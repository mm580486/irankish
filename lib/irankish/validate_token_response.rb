module Irankish
    class ValidateTokenResponse
      attr_reader :response, :status,:statusmessage
     
      def validate(response = nil)
        @response = response
        perform_validation
        return self
      end
  
      def valid?
        @valid
      end

      def get_token
        return @response[:make_token_response][:make_token_result][:token]
      end

      def full_message_errors
        return @response[:make_token_response][:make_token_result][:message]
      end
  
      private
      
      def perform_validation
        raise ArgumentError, 'not a valid response' if @response.nil?
        @valid = (@response[:make_token_response][:make_token_result][:message] == 'Success')
      end
      
    end
    
  end