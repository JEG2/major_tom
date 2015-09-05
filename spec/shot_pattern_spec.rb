require_relative "../lib/major_tom/point"
require_relative "../lib/major_tom/board"
require_relative "../lib/major_tom/shot_pattern"

describe MajorTom::ShotPattern do
  it "enumerates a list of shots" do
    pattern = MajorTom::ShotPattern.new(
      MajorTom::Board.new(width: 3, height: 2, ships: [5, 4, 3, 3, 2])
    )
    shots   = pattern.to_a
    expect(shots.sort).to eq(
      [[1, 0], [0, 1], [2, 1]].map { |x, y| MajorTom::Point.new(x: x, y: y) }
    )
  end
end
