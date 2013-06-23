require 'spec_helper'

describe Cradlepointr::Config do

  let(:router) { Cradlepointr::Router.new(ROUTER_ID) }
  let(:config) { Cradlepointr::Config.new(router, {}) }

  subject { config }
  it { should be }
  it { should respond_to(:id) }
  it { should respond_to(:data) }
  it { should respond_to(:router) }
  it { should respond_to(:config_settings) }
  it { should respond_to(:config_editor_id) }

  it 'should return the correct rel_url' do
    config.rel_url.should == '/configuration_editors/'
  end

  it 'should return the correct rel_url_with_id' do
    config.id = 123
    config.rel_url_with_id.should == '/configuration_editors/123/'
    config.id = nil
  end

  context 'when applying a configuration patch' do

  end
end