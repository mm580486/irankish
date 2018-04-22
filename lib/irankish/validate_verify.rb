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

  
      private
      
      def perform_validation
        raise ArgumentError, 'not a valid response' if @response.nil?
        @valid = (@response[:kiccc_payments_verification_response][:kiccc_payments_verification_result].to_i == 100)
      end
      
    end
    
  end