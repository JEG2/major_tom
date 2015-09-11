require 'set'

module MajorTom
  class BoardAnalyzer
    attr_reader :board
    private :board

    def initialize(board)
      @board        = board
      @hit_queue    = Set.new
      @handled_hits = Set.new
      check_for_hits
    end

    def new_hits?
      check_for_hits
      @hit_queue.any?
    end

    def pop_hit
      check_for_hits
      hit = @hit_queue.first
      @hit_queue.delete(hit)
      @handled_hits.add(hit)
      hit
    end

    private

    def check_for_hits
      find_hits.map { |hit| @hit_queue.add(hit) if @handled_hits.add?(hit) }
    end

    def find_hits
      board.recorded_shots.select { |point,hit_or_miss| hit_or_miss == :hit }.keys
    end

  end
end
