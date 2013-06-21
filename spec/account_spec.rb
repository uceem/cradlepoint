require 'spec_helper'

describe Cradlepointr::Account do

  context 'without an id' do

    let(:account) { Cradlepointr::Account.new }

    before do 
      authenticate_with_valid_credentials
      account.id
    end

    after { logout }

    it 'should lazy load the id' do
      account.id.should == ACCOUNT_ID
    end

    it 'should also assign the response to the data attribute' do
      account.data.should be
    end
  end

  context 'with an id' do

    let(:id) { 123 }
    let(:account) { Cradlepointr::Account.new(id) }

    it 'should return the id' do
      account.id.should == id
    end
  end
end