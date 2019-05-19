module Bluedart
  class CancelWaybill < Base
    def initialize(details)
      @profile = profile_hash({api_type: 'S', version: '1.8'}, details[:creds])
      @awb = details[:awb_no]
      @mode = details[:mode]
    end

    def request_url
      if @mode == 'prod'
        'https://netconnect.bluedart.com/Ver1.8/ShippingAPI/WayBill/WayBillGeneration.svc'
      else
        'https://netconnect.bluedart.com/Demo/ShippingAPI/WayBill/WayBillGeneration.svc'
      end
    end

    def response
      wsa = 'http://tempuri.org/IWayBillGeneration/CancelWaybill'
      # TODO: ITS A HACK NEEDS TO BE REMOVED
      # TODO: NEED TO REWRITE TO USE NAMESPACES DEFINED IN NAMESPACES FUNCTION
      params = {'Request' => {'ns4:AWBNo' => @awb}}
      opts = {message: 'CancelWaybill', wsa: wsa, params: params, extra: {'Profile' => @profile}, url: request_url}
      make_request(opts)
    end
  end
end