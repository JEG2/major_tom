require_relative "shot_pattern"
require_relative "outliner"

module MajorTom
  class AI
    def initialize(board)
      @board    = board
      @pattern  = ShotPattern.new(board)
      @queue    = [ ]
      @old_hits = [ ]
    end

    attr_reader :board, :pattern, :queue, :old_hits
    private     :board, :pattern, :queue, :old_hits

    def shots(count)
      queue_new_hits
      queued = take_queued_shots(count)
      supplement_from_pattern(queued, count)
    end

    private

    def queue_new_hits
      new_hits = board.hits - old_hits
      new_hits.each do |point|
        queue << Outliner.new(board: board, hit: point)
      end
      old_hits.concat(new_hits)
    end

    def take_queued_shots(count)
      shots = [ ]
      queue.delete_if { |outliner|
        outliner.each do |shot|
          shots << shot
          return shots if shots.size == count
        end
        true  # always delete when exhausted
      }
      shots
    end

    def supplement_from_pattern(shots, count)
      shots + pattern.take(count - shots.size)
    end
  end
end
