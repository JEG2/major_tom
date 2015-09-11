require_relative "../lib/major_tom/point"
require_relative "../lib/major_tom/board"
require_relative "../lib/major_tom/ai"

describe MajorTom::AI do


  # let(:shot_pattern) { MajorTom::ShotPattern.new(board) }
  # let(:outliner) { MajorTom::Outliner}
  # let(:ai) { MajorTom::AI.new(board: board, shot_pattern: shot_pattern, outliner: outliner) }

  # it 'recognizes new hits' do
  #   hit   = MajorTom::Point.new(x:1,y:1)
  #   hit2   = MajorTom::Point.new(x:1,y:2)

  #   expect(ai.new_hits).to eq([])
  #   board.record_hit(hit)
  #   expect(ai.new_hits).to eq([ hit ])
  #   board.record_hit(hit2)
  #   expect(ai.new_hits).to eq([ hit2 ])
  # end

  # it 'takes shots' do
  #   shots = strategies.first.take(3)
  #   expect(ai.shots(3)).to eq(shots)
  # end

  it 'switches strategies' do
    Analyzer  = Struct.new(:new_hits?, :pop_hits)
    analyzer  = Analyzer.new(false, MajorTom::Point.new(x:1,y:1))
    primary   = double
    secondary = double
    ai = MajorTom::AI.new(analyzer, primary: primary, secondary: secondary)

    count = 3
    expect(primary).to receive(:take).with(3)
    ai.shots(count)
  end

end
