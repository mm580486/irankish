module Irankish
    class ValidateVerify
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
        # return @response[:make_token_response][:make_token_result][:message]
      end
  
      private
      
      def perform_validation
        raise ArgumentError, 'not a valid response' if @response.nil?
        @valid = (@response[:get_limited_transacction_response][:get_limited_transacction_result][:RESULTCODE].to_i == 100)
      end
      
    end
    
  end