require 'spec_helper'

describe 'mars rover kata' do
  let(:world) { World.new(width: 100, height: 100, obstacles: 2) }
  let(:rover) { Rover.new(position: { x: 0, y: 0 }, direction: :n, world: world) }

  it 'should end up at (2, 2)' do
    binding.pry
    expect{rover.move('ffrff')}.to change{rover.position}.from({x: 0, y: 0}).to({x: 2, y: 2})
  end
end
