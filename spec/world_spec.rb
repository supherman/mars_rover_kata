require 'spec_helper'

describe World do
  subject { World.new width: 100, height: 100, obstacles: 2 }

  it 'has a defined size' do
    expect(subject.width).to_not be nil
    expect(subject.height).to_not be nil
  end

  it 'has at least one obstacle' do
    expect(subject.obstacles.size).to be >= 1
  end

  describe '#obstacle?' do
    before do
      subject.obstacles = [mock(position: { x: 10, y: 10 })]
    end

    it 'returns true when the given position is occupied by an obstacle' do
      expect(subject.obstacle?({ x: 10, y: 10 })).to be_true
    end

    it 'returns false when the given position is not occupied by an obstacle' do
      expect(subject.obstacle?({ x: 11, y: 10 })).to be_false
    end
  end

end
