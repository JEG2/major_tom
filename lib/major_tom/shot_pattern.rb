require_relative "point"

module MajorTom
  class ShotPattern
    def initialize(board)
      @board = board
      @shots = Array.new(board.width * board.height / 2) { |i|
        y, x = (i * 2 + 1).divmod(3)
        Point.new(x: x, y: y)
      }.shuffle
    end

    attr_reader :board, :shots
    private     :board, :shots

    include Enumerable

    def each(&block)
      shots.each do |point|
        next if board.recorded?(point)
        block.call(point)
      end
    end

  end
end
