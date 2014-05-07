require 'spec_helper'

describe Geese::Player do

  describe '#==' do
    let(:a) { player(name: 'John', color: 'grey') }
    let(:b) { player(name: 'Jane', color: 'grey') }

    it 'based on pawn color' do
      expect(a).to eq(b)
      expect(a).not_to eql(b)
    end
  end

  describe '#<=>' do
    let(:a) { player(name: 'Jane', age: 69) }
    let(:b) { player(name: 'John', age: 42) }

    subject { [a,b].sort }

    it 'based on age' do
      expect(subject).to eq([b, a])
    end
  end
end
