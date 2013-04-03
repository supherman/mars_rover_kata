class World
  attr_accessor :obstacles
  attr_reader :width, :height

  def initialize options = {}
    @width     = options[:width]
    @height    = options[:height]
    @obstacles = []
    seed_obstacles options[:obstacles]
  end

  def obstacle? position
   !@obstacles.find do |obstacle|
      obstacle.position == position
    end.nil?
  end

  private

  def seed_obstacles quantity
    quantity.times do
      @obstacles << Obstacle.new(position: { x: rand(100), y: rand(100) }, world: self)
    end
  end
end
