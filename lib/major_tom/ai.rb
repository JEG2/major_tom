module MajorTom
  class AI

    attr_reader :analyzer, :primary
    private :analyzer, :primary

    def initialize(analyzer, primary:, secondary:)
      @analyzer  = analyzer
      @primary   = primary
      @secondary = secondary
      @shots     = Array.new
    end

    def shots(count)
      outline_new_hits
      shots = []
      count.times do
        shots << @shots.pop || primary.take(1)
      end
      shots
    end

    private

    def outline_new_hits
      if analyzer.new_hits?
        @shots.push(*use_secondary_strategy)
      end
    end

    def use_secondary_strategy
      secondary.new(board, point).each.to_a
    end

  end
end
