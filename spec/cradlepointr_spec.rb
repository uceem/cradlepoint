require 'spec_helper'

describe Cradlepointr do

  let(:cradlepointr) { Cradlepointr }

  it { should be }

  context 'authentication' do

    it 'should raise an error if you make a request without credentials' do
      -> { cradlepointr.make_request(:fake) }.should raise_error
    end

    context 'with valid credentials' do

      before { cradlepointr.authenticate(:blah_user, :blah_password) }

      it 'should not raise an error' do
        -> { cradlepointr.make_request(:fake) }.should_not raise_error
      end
    end
  end
end