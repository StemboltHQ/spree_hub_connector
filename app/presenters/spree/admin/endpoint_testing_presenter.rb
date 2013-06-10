require "samples"

module Spree::Admin
  class EndpointTestingPresenter < SimpleDelegator
    def samples
      [
        OpenStruct.new(message: "order:persist"          , payload: Samples::Order.persist)          ,
        OpenStruct.new(message: "order:ship"             , payload: Samples::Order.ship)             ,
        OpenStruct.new(message: "order:capture"          , payload: Samples::Order.capture)          ,
        OpenStruct.new(message: "order:payment:captured" , payload: Samples::Order.payment_captured) ,
        OpenStruct.new(message: "shipment:confirmation"  , payload: Samples::Shipment.confirmation)
      ]
    end

    def each_response_data
      { uri: uri }.merge(code: response_code).
        merge(response_headers).
        merge(body: response_body).each do |key, value|
          yield key, value.kind_of?(Array) ? value.join(", ") :
            value
        end
    end
  end
end

