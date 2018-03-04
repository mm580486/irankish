require "savon"

module Irankish
    class GetToken
      include Validatable
      attr_accessor :amount,:getTokenWDSL,:sha1Key,:merchantId,:invoiceNumber,:revertURL,:paymentId,:description,:specialPaymentId,:extraParam1,:extraParam2,:extraParam3,:extraParam4
      attr_reader   :response
      validates_presence_of :amount
      validates_presence_of :merchantId
      validates_presence_of :invoiceNumber
      validates_presence_of :revertURL

      def initialize(args = {})
        @getTokenWDSL        = Savon.client(wsdl: args.fetch(:getTokenWDSL, Irankish.configuration.getTokenWDSL), pretty_print_xml: true)
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
        response = @getTokenWDSL.call :make_token, message: {
            'merchantId'       => @merchantId,
            'revertURL'        => @revertURL,
            'amount'           => @amount,
            'invoiceNumber'    => @invoiceNumber,
            'invoiceNo'        => @invoiceNumber
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