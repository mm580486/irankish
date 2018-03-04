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
      
      def full_message_errors
        return @response['msg'].to_s
      end
  
      private
      
      def perform_validation
        raise ArgumentError, 'not a valid response' if @response.nil?
        @valid = true
      end
      
    end
    
  end