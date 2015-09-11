require_relative "point"

module MajorTom
  class Board
    def initialize(width: , height: , ships: )
      @width          = width
      @height         = height
      @ships          = ships
      @recorded_shots = { }
    end

    attr_reader :width, :height, :ships

    attr_reader :recorded_shots

    def record_hit(point)
      recorded_shots[point] = :hit
    end

    def record_miss(point)
      recorded_shots[point] = :miss
    end

    def recorded?(point)
      recorded_shots.include?(point)
    end

    def hit?(point)
      recorded_shots[point] == :hit
    end

    def miss?(point)
      recorded_shots[point] == :miss
    end

    def on?(point)
      point.x.between?(0, width - 1) && point.y.between?(0, height - 1)
    end

    def neighbors(point)
      [ Point.new(x: point.x,     y: point.y - 1),
        Point.new(x: point.x + 1, y: point.y),
        Point.new(x: point.x,     y: point.y + 1),
        Point.new(x: point.x - 1, y: point.y) ].select { |point|
        on?(point)
      }
    end
  end
end
