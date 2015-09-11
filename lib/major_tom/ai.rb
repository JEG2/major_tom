module MajorTom
  class AI

    attr_reader :analyzer, :primary
    private :analyzer, :primary

    def initialize(analyzer, primary:, secondary:)
      @analyzer  = analyzer
      @primary   = primary
      @secondary = secondary
    end

    def shots(count)
      if analyzer.new_hits?
        secondary.new(board, analyzer.pop_hit)
      else
        primary.take(count)
      end
    end

  end
end
