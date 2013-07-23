require 'spec_helper'

describe Cradlepointr::NetFlow do

  let(:net_flow)      { Cradlepointr::NetFlow.new(ROUTER_MAC) }
  let(:net_flow_data) { net_flow.get }

  before { login }

  it 'should return successfully' do
    net_flow_data['success'].should be_true
  end
end