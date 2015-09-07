require_relative "point"

module MajorTom
  class ShipPlacement
    def initialize(point: , alignment: , size: )
      @point     = point
      @alignment = alignment
      @size      = size
    end

    attr_reader :point, :alignment, :size

    def points
      move = alignment == "H" ? ->(i) { {x: point.x + i, y: point.y}     }
                              : ->(i) { {x: point.x,     y: point.y + i} }
      Array.new(size) { |i| Point.new(move[i]) }
    end

    def to_s
      "#{point} #{alignment}"
    end
  end
end
