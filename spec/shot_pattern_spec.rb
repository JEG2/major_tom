require_relative "../lib/major_tom/point"
require_relative "../lib/major_tom/board"
require_relative "../lib/major_tom/shot_pattern"

describe MajorTom::ShotPattern do
  let(:board)   { MajorTom::Board.new(width: 3, height: 2, ships: [2]) }
  let(:pattern) { MajorTom::ShotPattern.new(board) }

  it "enumerates a list of shots" do
    shots = pattern.to_a
    expect(shots.sort).to eq(
      [[1, 0], [0, 1], [2, 1]].map { |x, y| MajorTom::Point.new(x: x, y: y) }
    )
  end

  it "skips known shots" do
    board.record_hit(MajorTom::Point.new(x: 0, y: 1))
    board.record_miss(MajorTom::Point.new(x: 2, y: 1))
    shots = pattern.to_a
    expect(shots.sort).to eq([MajorTom::Point.new(x: 1, y: 0)])
  end
end
