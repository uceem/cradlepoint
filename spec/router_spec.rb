require 'spec_helper'

describe Cradlepoint::Router do

  let(:router) { Cradlepoint::Router }

  subject { router }
  it { should be }

  it 'should provide the proper rel_url' do
    router.rel_url.should == '/routers'
  end

  it 'should provide the proper rel_url_with_id' do
    router.rel_url_with_id(123).should == '/routers/123/'
  end

  context 'when authenticated' do

    before { authenticate_with_valid_credentials }

    describe '.get' do

      let(:response)      { router.new(ROUTER_ID).get }
      let(:response_hash) { response['data']          }

      subject { response }
      it { should be }

      it 'should be successful' do
        response['success'].should be_true
      end

      it 'should raise an error when the id is not provided' do
        -> { router.get }.should raise_error
      end

      it 'should return the correct blob' do
        response['data'].any?.should be_true
      end

      it 'should have the correct keys' do
        ['full_product_name', 'config_status', 'mac'].all? { |k| response_hash.has_key?(k) }.should be_true
      end

      describe 'attrs' do

        let(:ecm_router) { router.new(ROUTER_ID) }
        let(:attrs) { [:mac, :config_status, :description, :full_product_name, :ip_address, :name, :stream_usage_in, 
                       :stream_usage_out, :stream_usage_period] }

        before { ecm_router.get }

        it 'should be assigned correctly' do
          attrs.each do |a|
            ecm_router.send(a).should == ecm_router.data['data'][a.to_s]
          end
        end
      end
    end

    describe '.index' do

      let(:response)      { router.index           }
      let(:response_hash) { response['data'].first }

      subject { response }
      it { should be }

      it 'should be successful' do
        response['success'].should be_true
      end

      it 'should return the correct blob' do
        response['data'].any?.should be_true
        response['data'].is_a?(Array).should be_true
      end
    end

    describe '.get_configuration_manager_data' do

      let(:the_router)  { router.new(ROUTER_ID) }

      before { the_router.configuration_manager_data }

      it 'should have gotten the configuration manager data' do
        the_router.ecm_configuration_manager_data.should be
      end
    end

    describe '.firmware_data' do

      let(:the_router) { router.new(ROUTER_ID) }

      it 'should have gotten the firmware data' do
        pending 'Waiting for updates to the firmware on the API side.'
        the_router.firmware_data['success'].should be_true
      end
    end

    describe '.apply_new_config' do

    end
  end
end
