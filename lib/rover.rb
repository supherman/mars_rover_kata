require 'world_positionable'

class Rover
  include WorldPositionable

  attr_accessor :direction
  attr_reader   :world
  attr_writer   :position

  def initialize(options = {})
    @direction = options[:direction]
    @position  = options[:position]
    @world     = options[:world]
  end

  def move_forward
    case direction
      when :n then update_position :y, 1
      when :s then update_position :y, -1
      when :e then update_position :x, 1
      when :w then update_position :x, -1
      else nil
    end
  end

  def move_backward
    case direction
      when :n then update_position :y, -1
      when :s then update_position :y, 1
      when :e then update_position :x, -1
      when :w then update_position :x, 1
      else nil
    end
  end

  def turn_left
    case direction
      when :n then @direction = :w
      when :s then @direction = :e
      when :e then @direction = :n
      when :w then @direction = :s
      else nil
    end
  end

  def turn_right
    case direction
      when :n then @direction = :e
      when :s then @direction = :w
      when :e then @direction = :s
      when :w then @direction = :n
      else nil
    end
  end

  def move command
    command.chars.each do |instruction|
      parse instruction
    end
  end

  private

  def parse instruction
    case instruction
      when 'f' then move_forward
      when 'b' then move_backward
      when 'l' then turn_left
      when 'r' then turn_right
      else nil
    end
  end

  def update_position axis, value
    new_position = @position.dup
    new_position[axis] += value
    @position = handle_obstacle new_position
  end

  def handle_obstacle next_position
    if @world.obstacle? next_position
      @position
    else
      next_position
    end
  end
end
