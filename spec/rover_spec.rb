require 'spec_helper'

describe Rover do
  let(:obstacle) { mock(position: { x: 55, y: 51 }) }
  let(:world) { mock(width: 100, height: 100, :obstacle? => false) }

  subject { Rover.new direction: :n, position: { x: 1, y: 2 }, world: world }

  it 'starts with a given position and direction' do
    expect(subject.direction).to_not be nil
    expect(subject.position).to_not be nil
  end

  describe '#move_forward' do
    context 'When facing north' do
      it 'should increment y position' do
        expect{subject.move_forward}.to change{subject.position[:y]}.by(1)
      end
    end

    context 'When facing south' do
      it 'should decrement y position' do
        subject.stub direction: :s
        expect{subject.move_forward}.to change{subject.position[:y]}.by(-1)
      end
    end

    context 'When facing east' do
      it 'should increment x position' do
        subject.stub direction: :e
        expect{subject.move_forward}.to change{subject.position[:x]}.by(1)
      end
    end

    context 'When facing west' do
      it 'should decrement x position' do
        subject.stub direction: :w
        expect{subject.move_forward}.to change{subject.position[:x]}.by(-1)
      end
    end

    context 'When an obstacle is encountered' do
      before do
        world.stub :obstacle? => true
      end

      it 'should not move forward' do
        expect{subject.move_forward}.to_not change{subject.position}
      end
    end
  end

  describe '#move_backward' do
    context 'When facing north' do
      it 'should decrement y position' do
        expect{subject.move_backward}.to change{subject.position[:y]}.by(-1)
      end
    end

    context 'When facing south' do
      it 'should increment y position' do
        subject.stub direction: :s
        expect{subject.move_backward}.to change{subject.position[:y]}.by(1)
      end
    end

    context 'When facing east' do
      it 'should decrement x position' do
        subject.stub direction: :e
        expect{subject.move_backward}.to change{subject.position[:x]}.by(-1)
      end
    end

    context 'When facing west' do
      it 'should increment x position' do
        subject.stub direction: :w
        expect{subject.move_backward}.to change{subject.position[:x]}.by(1)
      end
    end

    context 'When an obstacle is encountered' do
      before do
        world.stub :obstacle? => true
      end

      it 'should not move backward' do
        expect{subject.move_backward}.to_not change{subject.position}
      end
    end
  end

  describe '#turn_left' do
    context 'When facing north' do
      it 'should be facing west' do
        expect{subject.turn_left}.to change{subject.direction}.from(:n).to(:w)
      end
    end

    context 'When facing south' do
      it 'should be facing east' do
        subject.direction = :s
        expect{subject.turn_left}.to change{subject.direction}.from(:s).to(:e)
      end
    end

    context 'When facing east' do
      it 'should be facing north' do
        subject.direction = :e
        expect{subject.turn_left}.to change{subject.direction}.from(:e).to(:n)
      end
    end

    context 'When facing west' do
      it 'should be facing south' do
        subject.direction = :w
        expect{subject.turn_left}.to change{subject.direction}.from(:w).to(:s)
      end
    end
  end

  describe '#turn_right' do
    context 'When facing north' do
      it 'should be facing east' do
        expect{subject.turn_right}.to change{subject.direction}.from(:n).to(:e)
      end
    end

    context 'When facing south' do
      it 'should be facing west' do
        subject.direction = :s
        expect{subject.turn_right}.to change{subject.direction}.from(:s).to(:w)
      end
    end

    context 'When facing east' do
      it 'should be facing south' do
        subject.direction = :e
        expect{subject.turn_right}.to change{subject.direction}.from(:e).to(:s)
      end
    end

    context 'When facing west' do
      it 'should be facing north' do
        subject.direction = :w
        expect{subject.turn_right}.to change{subject.direction}.from(:w).to(:n)
      end
    end
  end

  it 'moves to the left with "l"' do
    subject.should_receive(:turn_left)
    subject.move('l')
  end

  it 'moves to the right with "r"' do
    subject.should_receive(:turn_right)
    subject.move('r')
  end

  it 'moves forward with "f"' do
    subject.should_receive(:move_forward)
    subject.move('f')
  end

  it 'moves backwards with "b"' do
    subject.should_receive(:move_backward)
    subject.move('b')
  end

  it 'moves with a given command' do
    subject.should_receive :move_forward
    subject.should_receive :move_forward
    subject.should_receive :turn_left
    subject.should_receive :move_forward
    subject.should_receive :turn_right
    subject.should_receive :move_backward

    subject.move('fflfrb')
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
