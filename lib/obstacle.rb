require 'world_positionable'

class Obstacle
  include WorldPositionable

  attr_reader :world
  attr_writer :position

  def initialize(options = {})
    @position = options[:position]
    @world    = options[:world]
  end
end
