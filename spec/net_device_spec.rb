require 'spec_helper'

describe Cradlepoint::NetDevice do

  let(:net_device) { Cradlepoint::NetDevice }

  subject { net_device.new }
  it { should be }
  it { should respond_to(:id) }
  it { should respond_to(:data) }
  it { should respond_to(:router) }

  it 'should provide the proper rel_url' do
    net_device.rel_url_from_router(123).should == '/routers/123/net_devices/'
  end

  context 'when authenticated' do

    let(:router) { Cradlepoint::Router.new(ROUTER_ID) }

    before { login }

    describe '.get_all_from_router_as_hash' do

      let(:response) { net_device.new(nil, router).get_all_from_router_as_hash }

      subject { response }
      it { should be }

      it 'should return a an array of hashes' do
        response.is_a?(Array).should be_true
        response.each { |h| h.is_a?(Hash).should be_true }
      end
    end

    describe '.get_all_from_router' do

      let(:device)  { net_device.new(nil, router) }
      let(:devices) { device.get_all_from_router }

      before { devices }

      it 'should raise an error when there is no router' do
        device_with_no_router = net_device.new
        -> { device_with_no_router.get_all_from_router }.should raise_error
      end

      it 'should return a blob' do
        devices.any?.should be_true
      end

      it 'should be an array' do
        device.data.is_a?(Array).should be_true
      end

      describe 'devices' do

        let(:first_net_device) { devices.first }
        let(:first_raw_data)   { device.data.first }
        let(:attrs)            { [:bytes_in, :bytes_out, :carrier, :esn, :imei, :info, 
                                  :ip_address, :mac, :mode, :name, :type, :uptime] }

        it 'should return an array' do
          devices.is_a?(Array).should be_true
        end

        it 'should return an array of Cradlepoint::NetDevices' do
          devices.each { |d| d.is_a?(Cradlepoint::NetDevice).should be_true }
        end

        it 'should have the correct attributes' do
          attrs.each do |a|
            first_net_device.send(a).should == first_raw_data[a]
          end
        end
      end
    end
  end
end
