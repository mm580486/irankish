require "savon"

module Irankish
    class Verify
      include Validatable
      attr_accessor :merchantId,:referenceNumber,:sha1Key,:token
      attr_reader   :response

      validates_presence_of :token
      validates_presence_of :merchantId
      validates_presence_of :referenceNumber
      validates_presence_of :sha1Key


      def initialize(args = {})
        @getTokenWSDL        = Savon.client(wsdl: args.fetch(:verfiyWSDL, Irankish.configuration.verifyWSDL),namespaces: {
          "xmlns:tem"     => "http://tempuri.org/",
          "xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/"
      },
      namespace_identifier: :tem,
      env_namespace: :soapenv,
      log: true, # set true to switch on logging
      log_level: :debug,
      element_form_default: :qualified,
      pretty_print_xml: true,
      open_timeout: 3000000,
      read_timeout: 3000000,
      encoding: "UTF-8"
  )
        @sha1Key             = args.fetch(:sha1Key, Irankish.configuration.sha1Key)
        @merchantId          = args.fetch(:merchantId, Irankish.configuration.merchantId)
        @amount              = args.fetch(:amount)
        @referenceNumber     = args.fetch(:referenceNumber)
        @token               = args.fetch(:amount)
        @response            = ValidateVerify.new()
      end

      
      def call

        
        response = @getTokenWSDL.call :kiccc_payments_verification, message: {
          'token'            => @token,
          'merchantId'       => @merchantId,
          'referenceNumber'  => @referenceNumber,
          'sha1Key'          => @sha1Key
        }
        @response.validate(response.body)
      end
  
  end 

end




