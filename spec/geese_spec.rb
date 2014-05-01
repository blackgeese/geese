require 'spec_helper'

describe Geese do
  it 'should have a version number' do
    Geese::VERSION.should_not be_nil
  end
end
