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

    before { login }

    describe '.get' do

      describe 'attrs' do

        let(:ecm_router) { router.new(ROUTER_ID) }
        let(:attrs) { [:mac, :config_status, :description, :full_product_name, :ip_address, :name, :stream_usage_in, 
                       :stream_usage_out, :stream_usage_period] }

        before { ecm_router.get }

        it 'should be assigned correctly' do
          attrs.each do |a|
            ecm_router.send(a).should == ecm_router.data[a]
          end
        end
      end
    end

    describe '.index' do

      let(:routers) { router.index }

      it 'should return routers' do
        routers.any?.should be_true
      end

      it 'should return the correct collection' do
        routers.is_a?(Array).should be_true
      end

      it 'should be of the correct type' do
        routers.each{ |r| r.is_a?(Cradlepoint::Router).should be_true }
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

      it 'should return nil when no firmware_uri exists' do
        the_router.ecm_firmware_uri = nil
        the_router.firmware_data.should be_nil
      end
    end
  end
end
