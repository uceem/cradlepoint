require 'spec_helper'

describe Cradlepoint do

  let(:cradlepoint) { Cradlepoint }

  subject { cradlepoint }
  it { should be }
  it { should respond_to(:username) }
  it { should respond_to(:password) }

  context 'authentication' do

    it 'should raise an error if you make a request without credentials' do
      -> { cradlepoint.make_request(:fake) }.should raise_error
    end

    context 'with credentials' do

      before { cradlepoint.authenticate(:blah_user, :blah_password) }

      it 'should not raise an error' do
        -> { cradlepoint.make_request(:fake) }.should_not raise_error
      end
    end
  end

  context 'make_request' do

    before { authenticate_with_valid_credentials }

    it 'should return the proper credentials' do
      cradlepoint.username.should == USERNAME
      cradlepoint.password.should == PASSWORD
    end
  end
end
