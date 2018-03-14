require "savon"

module Irankish
    class GetToken
      include Validatable
      attr_accessor :amount,:getTokenWSDL,:sha1Key,:merchantId,:invoiceNumber,:revertURL,:paymentId,:description,:specialPaymentId,:extraParam1,:extraParam2,:extraParam3,:extraParam4
      attr_reader   :response
      validates_presence_of :amount
      validates_presence_of :merchantId
      validates_presence_of :invoiceNumber
      validates_presence_of :revertURL

      def initialize(args = {})
        @getTokenWSDL        = Savon.client(wsdl: args.fetch(:getTokenWSDL, Irankish.configuration.getTokenWSDL),namespaces: {
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
        @revertURL           = args.fetch(:revertURL, Irankish.configuration.revertURL)
        @amount              = args.fetch(:amount)
        @invoiceNumber       = args.fetch(:invoiceNumber)
        @paymentId           = args.fetch(:paymentId,'')
        @description         = args.fetch(:description,'')
        @specialPaymentId    = args.fetch(:specialPaymentId,'')
        @extraParam1         = args.fetch(:extraParam1,'')
        @extraParam2         = args.fetch(:extraParam2,'')
        @extraParam3         = args.fetch(:extraParam3,'')
        @extraParam4         = args.fetch(:extraParam4,'')
        @response            = ValidateTokenResponse.new()
      end

      
      def call
        response = @getTokenWSDL.call :make_token, message: {
          'amount'           => @amount,   
          'merchantId'       => @merchantId,
          'invoiceNo'        => @invoiceNumber,
          'revertURL'        => @revertURL
            

            # 'paymentId'        => @paymentId,
            # 'description'      => @description,
            # 'specialPaymentId' => @specialPaymentId,
            # 'extraParam1'      => @extraParam1,
            # 'extraParam2'      => @extraParam2,
            # 'extraParam3'      => @extraParam3,
            # 'extraParam4'      => @extraParam4
        }
        @response.validate(response.body)
      end
  
  end 

end




