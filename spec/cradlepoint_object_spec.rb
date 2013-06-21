require 'spec_helper'

describe Cradlepointr::CradlepointObject do

  let(:factory_cradlepoint_object) { Cradlepointr::CradlepointObject     }
  let(:cradlepoint_object)         { Cradlepointr::CradlepointObject.new }

  let(:url) { 'https://:@beta.cradlepointecm.com/api/v1/blah?format=json' }

  context 'factory' do

    it 'should return the correct url' do
      factory_cradlepoint_object.build_url(:blah).should == url
    end
  end

  context 'initialized object' do

    it 'should return the correct url' do
      cradlepoint_object.build_url(:blah).should == url
    end
  end
end