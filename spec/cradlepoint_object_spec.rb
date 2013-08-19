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
  end
end
