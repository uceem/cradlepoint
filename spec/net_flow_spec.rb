require 'spec_helper'

describe Cradlepoint::NetFlow do

  let(:net_flow) { Cradlepoint::NetFlow.new(ROUTER_MAC) }

  before { login }

  describe '.get' do

    let(:net_flow_data) { net_flow.get }

    it 'should return successfully' do
      net_flow_data['success'].should be_true
    end
  end

  describe '.get_status' do

    let(:net_flow_status_data) { net_flow.get_status }

    it 'should return data successfully' do
      net_flow_status_data['success'].should be_true
    end
  end
end
