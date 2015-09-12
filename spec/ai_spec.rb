require_relative "../lib/major_tom/point"
require_relative "../lib/major_tom/board"
require_relative "../lib/major_tom/shot_pattern"
require_relative "../lib/major_tom/outliner"
require_relative "../lib/major_tom/ai"

describe MajorTom::AI do
  let(:board)    { MajorTom::Board.new(width: 3, height: 2, ships: [2]) }
  let(:pattern)  { MajorTom::ShotPattern.new(board) }
  let(:hit)      { MajorTom::Point.new(x: 2, y: 1) }
  let(:outliner) { MajorTom::Outliner.new(board: board, hit: hit) }
  let(:ai)       { MajorTom::AI.new(board) }

  it "defaults to the shot pattern" do
    expect(ai.shots(3).sort).to eq(pattern.to_a.sort)
  end

  it "will outline new hits" do
    board.record_hit(hit)
    expect(ai.shots(2).sort).to eq(outliner.take(2).sort)
  end

  it "supplements shots from the pattern as needed" do
    board.record_hit(hit)
    expect(ai.shots(4).sort).to eq((outliner.take(2) + pattern.take(2)).sort)
  end
end
