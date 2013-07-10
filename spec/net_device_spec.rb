require 'spec_helper'

describe Cradlepointr::NetDevice do

  let(:net_device) { Cradlepointr::NetDevice }

  subject { net_device.new }
  it { should be }
  it { should respond_to(:id) }
  it { should respond_to(:data) }
  it { should respond_to(:router) }

  it 'should provide the proper rel_url' do
    net_device.rel_url_from_router(123).should == '/routers/123/net_devices/'
  end

  context 'when authenticated' do

    before { authenticate_with_valid_credentials }

    describe '.get_all_from_router' do

      let(:router) { Cradlepointr::Router.new(ROUTER_ID) }
      let(:device) { net_device.new(nil, router) }

      before { device.get_all_from_router }

      it 'should have been successful' do
        device.data['success'].should be_true
      end

      it 'should raise an error when there is no router' do
        device_with_no_router = net_device.new
        -> { device_with_no_router.get_all_from_router }.should raise_error
      end

      # TODO: Overhaul these to allow them to endure the test of time.
      # These are brittle, temporary tests to make sure the correct
      # blob is being returned.
      it 'should return a blob' do
        device.data['data'].any?.should be_true
      end

      it 'should be an array' do
        device.data['data'].is_a?(Array).should be_true
      end

      it 'should have the correct keys' do
        ['bytes_in', 'bytes_out'].all? { |k| device.data['data'].first.has_key?(k) }.should be_true
        device.data['data'][1]['config'].is_a?(Hash).should be_true
      end
    end
  end
end