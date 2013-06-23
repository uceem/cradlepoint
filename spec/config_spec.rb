require 'spec_helper'

describe Cradlepointr::Config do

  let(:router) { Cradlepointr::Router.new(ROUTER_ID) }
  let(:config) { Cradlepointr::Config.new(router, {}) }

  before do 
    Cradlepointr.account = Cradlepointr::Account.new(ACCOUNT_ID)
    authenticate_with_valid_credentials
  end
  after { logout }

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

  context 'configuration patch' do

    describe '.create_editor' do

      before { config.create_editor }
      after  { config.data = nil    }

      it 'should have been successful' do
        config.data['success'].should be_true
      end
    end

    describe '.remove_editor' do

      before { config.remove_editor }
      after  { config.data = nil    }

      it 'should have been successful' do
        config.data['success'].should be_true
      end
    end
  end
end