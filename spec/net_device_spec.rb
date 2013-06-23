require 'spec_helper'

describe Cradlepointr::NetDevice do

  let(:net_device) { Cradlepointr::NetDevice }

  subject { net_device.new }
  it { should be }
  it { should respond_to(:id) }
  it { should respond_to(:router) }

  it 'should provide the proper rel_url' do
    net_device.rel_url_from_router(123).should == '/routers/123/net_devices/'
  end

  context 'when authenticated' do

    before { authenticate_with_valid_credentials }

    describe '.get_all_from_router' do

      let(:router)        { Cradlepointr::Router.new(ROUTER_ID) }
      let(:response)      { net_device.new(nil, router).get_all_from_router }
      let(:response_hash) { response['data'].first }

      subject { response }
      it { should be }

      it 'should be successful' do
        response['success'].should be_true
      end

      it 'should raise an error when the router_id is not provided' do
        -> { net_device.get }.should raise_error
      end

      it 'should return the correct blob' do
        response['data'].any?.should be_true
        response['data'].is_a?(Array).should be_true
      end

      it 'should have the correct keys' do
        ['bytes_in', 'bytes_out'].all? { |k| response_hash.has_key?(k) }.should be_true
        response_hash['config'].is_a?(Hash).should be_true
      end
    end
  end
end