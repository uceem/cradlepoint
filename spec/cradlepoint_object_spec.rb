require 'spec_helper'

describe Cradlepoint::CradlepointObject do

  let(:factory_cradlepoint_object) { Cradlepoint::CradlepointObject     }
  let(:cradlepoint_object)         { Cradlepoint::CradlepointObject.new }

  let(:url) { 'https://:@cradlepointecm.com/api/v1/blah' }

  context 'factory' do

    it 'should return the correct url' do
      factory_cradlepoint_object.build_url('/blah').should == url
    end
  end

  context 'initialized object' do

    it 'should return the correct url' do
      cradlepoint_object.build_url('/blah').should == url
    end

    describe '.successful_response?' do

      let(:successful_response) { [] }
      let(:unsuccessful_responses) { [nil, { success: false }] }

      it 'should think a successful response is successful' do
        cradlepoint_object.successful_response?(successful_response).should be_true
      end

      it 'should think unsuccessful responses are unsuccessful' do
        unsuccessful_responses.each { |r| cradlepoint_object.successful_response?(r).should be_false }
      end
    end
  end
end
