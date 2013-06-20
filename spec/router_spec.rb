require 'spec_helper'

describe Cradlepointr::Router do

  let(:router) { Cradlepointr::Router }

  subject { router }
  it { should be }

  it 'should provide the proper rel_url' do
    router.rel_url.should == '/routers'
  end

  it 'should provide the proper rel_url_with_id' do
    router.rel_url_with_id(123).should == '/routers/123'
  end

  context 'when authenticated' do

    before { authenticate_with_valid_credentials }

    describe '.get' do

      let(:response)      { router.get(ROUTER_ID)  }
      let(:response_hash) { response['data']       }

      subject { response }
      it { should be }

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
  end
end