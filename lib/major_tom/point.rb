module MajorTom
  class Point
    def self.parse(string)
      x, y = string.split.map(&:to_i)
      new(x: x, y: y)
    end

    def initialize(x: , y: )
      @x = x
      @y = y
    end

    attr_reader :x, :y

    include Comparable

    def ==(other)
      self.class == other.class && x == other.x && y == other.y
    end
    alias_method :eql?, :==

    def <=>(other)
      fail "Not a #{self.class.name}" unless self.class == other.class

      [y, x] <=> [other.y, other.x]
    end

    def hash
      [self.class, x, y].hash
    end

    def to_s
      "#{x} #{y}"
    end
  end
end
