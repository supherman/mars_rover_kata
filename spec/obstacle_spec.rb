require 'spec_helper'

describe Obstacle do
  subject { Obstacle.new position: { x: 1, y: 2 }, world: mock(width: 100, height: 100) }
  it 'has a x position' do
    expect(subject.position[:x]).to_not be_nil
  end

  it 'has a y position' do
    expect(subject.position[:y]).to_not be_nil
  end

  it 'belongs to a world' do
    expect(subject.world).to_not be_nil
  end

  describe '#position related to the world' do
    context 'When x is overflowed' do
      it 'wraps x boundaries' do
        subject.position = { x: 120, y: 45 }
        expect(subject.position).to eq({ x: 20, y: 45 })

        subject.position = { x: -30, y: 45 }
        expect(subject.position).to eq({ x: 70, y: 45 })

        subject.position = { x: -150, y: 45 }
        expect(subject.position).to eq({ x: 50, y: 45 })
      end
    end

    context 'When y is overflowed' do
      it 'wraps y boundaries' do
        subject.position = { x: 10, y: 120 }
        expect(subject.position).to eq({ x: 10, y: 20 })

        subject.position = { x: 10, y: -30 }
        expect(subject.position).to eq({ x: 10, y: 70 })

        subject.position = { x: 10, y: -150 }
        expect(subject.position).to eq({ x: 10, y: 50 })
      end
    end
  end
end
