require 'spec_helper'

describe Cradlepointr::Router do

  let(:router) { Cradlepointr::Router }

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

    describe '.apply_new_config' do

    end
  end
end