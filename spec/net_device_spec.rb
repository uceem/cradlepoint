require 'spec_helper'

describe Cradlepointr::NetDevice do

  let(:net_device) { Cradlepointr::NetDevice }

  subject { net_device }
  it { should be }
  it { should respond_to(:router_id) }

  it 'should raise an error with a .get when a router_id is not provided' do
    -> { net_device.get }.should raise_error
  end

  it 'should provide the proper rel_url' do
    net_device.rel_url(123).should == '/routers/123/net_devices/'
  end
end