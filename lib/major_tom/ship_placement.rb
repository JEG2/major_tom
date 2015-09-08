require_relative "point"

module MajorTom
  class ShipPlacement
    def initialize(point: , horizontal: , size: )
      @point      = point
      @horizontal = horizontal
      @size       = size
    end

    attr_reader :point, :size

    def horizontal?
      @horizontal
    end

    def vertical?
      !horizontal?
    end

    def points
      move = horizontal? ? ->(i) { {x: point.x + i, y: point.y}     }
                         : ->(i) { {x: point.x,     y: point.y + i} }
      Array.new(size) { |i| Point.new(move[i]) }
    end

    def to_s
      "#{point} #{horizontal? ? 'H' : 'V'}"
    end
  end
end
