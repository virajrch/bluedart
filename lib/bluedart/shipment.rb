module Bluedart
  class Shipment < Base
    def initialize(details)
      @shipper = shipper_hash(details[:shipper_details])
      @consignee = consignee_hash(details[:consignee_details])
      @services = services_hash(details[:services])
      @profile = profile_hash({api_type: 'S', version: '1.8'}, details[:creds])
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
      wsa = 'http://tempuri.org/IWayBillGeneration/GenerateWayBill'
      # TODO: ITS A HACK NEEDS TO BE REMOVED
      # TODO: NEED TO REWRITE TO USE NAMESPACES DEFINED IN NAMESPACES FUNCTION
      params = {'Request' => {'ns4:Consignee' => @consignee, 'ns4:Services' => @services, 'ns4:Shipper' => @shipper}}
      opts = {message: 'GenerateWayBill', wsa: wsa, params: params, extra: {'Profile' => @profile}, url: request_url}
      make_request(opts)
    end

    def to_request_xml
      wsa = 'http://tempuri.org/IWayBillGeneration/GenerateWayBill'
      # TODO: ITS A HACK NEEDS TO BE REMOVED
      # TODO: NEED TO REWRITE TO USE NAMESPACES DEFINED IN NAMESPACES FUNCTION
      params = {'Request' => {'ns4:Consignee' => @consignee, 'ns4:Services' => @services, 'ns4:Shipper' => @shipper}}
      opts = {message: 'GenerateWayBill', wsa: wsa, params: params, extra: {'Profile' => @profile}, url: request_url}
      request_xml(opts)
    end

    private
    def shipper_hash(details)
      params = {}
      address_array = multi_line_address(details[:address], 30)
      params['CustomerAddress1'] = address_array[0]
      params['CustomerAddress2'] = address_array[1]
      params['CustomerAddress3'] = address_array[2]
      params['CustomerCode'] = details[:customer_code]
      params['CustomerEmailID'] = details[:customer_email_id]
      params['CustomerMobile'] = details[:customer_mobile]
      params['CustomerName'] = details[:customer_name]
      params['CustomerPincode'] = details[:customer_pincode]
      params['CustomerTelephone'] = details[:customer_telephone]
      params['IsToPayCustomer'] = details[:isToPayCustomer]
      params['OriginArea'] = details[:origin_area]
      params['Sender'] = details[:sender]
      params['VendorCode'] = details[:vendor_code]
      params
    end

    def consignee_hash(details)
      params = {}
      address_array = multi_line_address(details[:address], 30)
      params['ConsigneeAddress1'] = address_array[0]
      params['ConsigneeAddress2'] = address_array[1]
      params['ConsigneeAddress3'] = address_array[2]
      params['ConsigneeAttention'] = details[:consignee_attention]
      params['ConsigneeMobile'] = details[:consignee_mobile]
      params['ConsigneeName'] = details[:consignee_name]
      params['ConsigneePincode'] = details[:consignee_pincode]
      params['ConsigneeTelephone'] = details[:consignee_telephone]
      params
    end

    def services_hash(details)
      params = {}
      params['ActualWeight'] = details[:actual_weight]
      params['CollectableAmount'] = details[:collactable_amount]
      params['Commodity'] = commodites_hash(details[:commodities])
      params['CreditReferenceNo'] = details[:credit_reference_no]
      params['DeclaredValue'] = details[:declared_value]
      params['Dimensions'] = dimensions_hash(details[:diemensions])
      params['IsReversePickup'] = details[:is_reverse_pickup]
      params['InvoiceNo'] = details[:invoice_no]
      params['IsForcePickup'] = details[:is_force_pickup]
      params['ItemCount'] = details[:item_count]
      params['PickupDate'] = details[:pickup_date]
      params['PickupTime'] = details[:pickup_time]
      params['PieceCount'] = details[:piece_count]
      params['ProductCode'] = details[:product_code]
      params['ProductType'] = details[:product_type]
      params['RegisterPickup'] = details[:register_pickup]
      params['SubProductCode'] = details[:sub_product_code]
      params['itemdtl'] = itemdtl_hash(details[:itemdtl])
      params['PackType'] = details[:pack_type]
      params['SpecialInstruction'] = details[:special_instruction]
      params['PDFOutputNotRequired'] = details[:p_d_f_output_not_required]
      params
    end

    def dimensions_hash(details)
      params = []
      details.each do |d|
        params << {'Dimension' => {'Breadth' => d[:breadth], 'Height' => d[:height], 'Length' => d[:length], 'Count' => d[:count]} }
      end
      params
    end

    def commodites_hash(details)
      params = {}
      details.each_with_index {|d, i| params["CommodityDetail#{i+1}"] = d}
      params
    end

    def itemdtl_hash(details)
      params = []
      details.each do |item| 
        params << {'ItemDetails' => {'ItemID' => item[:item_id], 'ItemName' => item[:item_name]}}
      end
      params
    end
  end
end