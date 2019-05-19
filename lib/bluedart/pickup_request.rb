module Bluedart
  class PickupRequest < Base
    def initialize(details)
      @product_code = details[:product_code]
      @area_code = details[:area_code]
      @customer_code = details[:customer_code]
      @customer_name = details[:customer_name]
      @customer_address1 = details[:customer_address1]
      @customer_address2 = details[:customer_address2]
      @customer_address3 = details[:customer_address3]
      @customer_pincode = details[:customer_pincode]
      @mobile_tel_no = details[:mobile_tel_no]
      @shipment_pickup_date = details[:shipment_pickup_date]
      @shipment_pickup_time = details[:shipment_pickup_time]
      @office_close_time = details[:office_close_time]
      @email_id = details[:email_id]
      @reference_no = details[:reference_no]
      @awb_no = details[:awb_no]
      @is_reverse_pickup = details[:is_reverse_pickup]
      @contact_person_name = details[:contact_person_name]
      @volume_weight = details[:volume_weight]
      @weight_of_shipment = details[:weight_of_shipment]
      
      @profile = profile_hash({api_type: 'S', version: '1.3'}, details[:creds])
      @mode = details[:mode]
    end

    def request_url
      if @mode == 'prod'
        'https://netconnect.bluedart.com/Ver1.7/ShippingAPI/Pickup/PickupRegistrationService.svc'
      else
        'https://netconnect.bluedart.com/Demo/ShippingAPI/Pickup/PickupRegistrationService.svc'
      end
    end

    def response
      wsa = 'http://tempuri.org/IPickupRegistration/RegisterPickup'
      params = {'request' => {'ns5:AreaCode' => @area_code, 'ns5:ContactPersonName'=> @contact_person_name,
                              'ns5:CustomerAddress1'=> @customer_address1, 'ns5:CustomerAddress2'=> @customer_address2, 'ns5:CustomerAddress3'=> @customer_address3,
                              'ns5:CustomerCode'=> @customer_code, 'ns5:CustomerName'=> @customer_name, 'ns5:CustomerPincode'=> @customer_pincode, 'ns5:MobileTelNo'=> @mobile_tel_no,
                              'ns5:OfficeCloseTime'=> @office_close_time, 'ns5:ProductCode'=> @product_code, 'ns5:ReferenceNo'=> @reference_no, 
                              'ns5:ShipmentPickupDate'=> @shipment_pickup_date, 'ns5:ShipmentPickupTime'=> @shipment_pickup_time,
                              'ns5:EmailID'=> @email_id, 'ns5:VolumeWeight' => @volume_weight, 'ns5:WeightofShipment' => @weight_of_shipment, 
                              'ns5:AWBNo'=> @awb_no, 'ns5:IsReversePickup'=> @is_reverse_pickup
                            }}
      opts = {message: 'RegisterPickup', wsa: wsa, params: params, extra: {'profile' => @profile}, url: request_url}
      make_request(opts)
    end

    def opts
      wsa = 'http://tempuri.org/IPickupRegistration/RegisterPickup'
      params = {'request' => {'ns5:AreaCode' => @area_code, 'ns5:ContactPersonName'=> @contact_person_name,
                              'ns5:CustomerAddress1'=> @customer_address1, 'ns5:CustomerAddress2'=> @customer_address2, 'ns5:CustomerAddress3'=> @customer_address3,
                              'ns5:CustomerCode'=> @customer_code, 'ns5:CustomerName'=> @customer_name, 'ns5:CustomerPincode'=> @customer_pincode, 'ns5:MobileTelNo'=> @mobile_tel_no,
                              'ns5:OfficeCloseTime'=> @office_close_time, 'ns5:ProductCode'=> @product_code, 'ns5:ReferenceNo'=> @reference_no, 
                              'ns5:ShipmentPickupDate'=> @shipment_pickup_date, 'ns5:ShipmentPickupTime'=> @shipment_pickup_time,
                              'ns5:EmailID'=> @email_id, 'ns5:VolumeWeight' => @volume_weight, 'ns5:WeightofShipment' => @weight_of_shipment, 
                              'ns5:AWBNo'=> @awb_no, 'ns5:IsReversePickup'=> @is_reverse_pickup
                            }}
      opts = {message: 'RegisterPickup', wsa: wsa, params: params, extra: {'profile' => @profile}, url: request_url}
      #make_request(opts)
      opts
    end
  end
end