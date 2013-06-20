require 'spec_helper'

describe Cradlepointr::NetDevice do

  let(:net_device) { Cradlepointr::NetDevice }

  subject { net_device }
  it { should be }
  it { should respond_to(:router_id) }

  it 'should provide the proper rel_url' do
    net_device.rel_url(123).should == '/routers/123/net_devices/'
  end

  context 'when authenticated' do

    before { authenticate_with_valid_credentials }

    describe '.get' do

      let(:response)      { net_device.get(ROUTER_ID) }
      let(:response_hash) { response['data'].first    }

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