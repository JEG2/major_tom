require_relative "../lib/major_tom/point"
require_relative "../lib/major_tom/board"
require_relative "../lib/major_tom/outliner"

describe MajorTom::Outliner do
  it "lists shots until the ship is outlined" do
    # ~~~
    # ~SS
    board    = MajorTom::Board.new(width: 3, height: 2)
    hit      = MajorTom::Point.new(x: 1, y: 1)
    outliner = MajorTom::Outliner.new(board: board, hit: hit)
    shots    = [ ]
    board.record_hit(hit)
    outliner.each do |shot|
      shots << shot
      if shot == MajorTom::Point.new(x: 2, y: 1)
        board.record_hit(shot)
      else
        board.record_miss(shot)
      end
    end
    expect(shots.sort).to eq(
      [[1, 0], [2, 0], [0, 1], [2, 1]].map { |x, y|
        MajorTom::Point.new(x: x, y: y)
      }
    )
  end
end
