module WorldPositionable
  def position
    { x: real_x_position, y: real_y_position }
  end

  private

  def real_x_position
    @position[:x] % @world.width
  end

  def real_y_position
    @position[:y] % @world.height
  end
end
