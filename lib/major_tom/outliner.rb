module MajorTom
  class Outliner
    def initialize(board: , hit: )
      @board = board
      @hit   = hit
    end

    attr_reader :board, :hit
    private     :board, :hit

    def each(&block)
      board.neighbors(hit).shuffle.each do |point|
        next if board.recorded?(point)
        block.call(point)
        if board.hit?(point)
          self.class.new(board: board, hit: point).each(&block)
        end
      end
    end
  end
end
