require 'spec_helper'

describe Cradlepointr do

  let(:cradlepointr) { Cradlepointr }

  it { should be }

  context 'authentication' do

    it 'should raise an error if you make a request without credentials' do
      -> { cradlepointr.make_request }.should raise_error
    end
  end
end