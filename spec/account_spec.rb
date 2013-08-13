require 'spec_helper'

describe Cradlepoint::Account do

  context 'without an id' do

    let(:account) { Cradlepoint::Account.new }

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
    let(:account) { Cradlepoint::Account.new(id) }

    it 'should return the id' do
      account.id.should == id
    end
  end

  describe '.rel_url' do

    let(:rel_url) { '/accounts' }

    it 'should return the proper rel_url from the factory' do
      Cradlepoint::Account.rel_url.should == rel_url
    end

    it 'should return the proper rel_url' do
      Cradlepoint::Account.new.rel_url.should == rel_url
    end
  end

  describe '.rel_url_with_id' do

    let(:id) { 123 }
    let(:rel_url_with_id) { "/accounts/#{ id }/" }
    let(:account) { Cradlepoint::Account.new(id) }

    it 'should return the proper rel_url_with_id from the factory' do
      Cradlepoint::Account.rel_url_with_id(id).should == rel_url_with_id
    end

    it 'should return the proper rel_url_with_id' do
      account.rel_url_with_id.should == rel_url_with_id
    end
  end
end
