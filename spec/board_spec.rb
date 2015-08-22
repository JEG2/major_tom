require_relative "../lib/major_tom/point"
require_relative "../lib/major_tom/board"

describe MajorTom::Board do
  let(:board) { MajorTom::Board.new(width: 3, height: 2) }

  it "tracks its size" do
    expect(board.width).to  eq(3)
    expect(board.height).to eq(2)
  end

  it "tracks shots made" do
    shot = MajorTom::Point.new(x: 0, y: 1)
    expect(board).not_to be_recorded(shot)
    board.record_hit(shot)
    expect(board).to     be_recorded(shot)
    expect(board).to     be_hit(shot)
    expect(board).not_to be_miss(shot)
  end

  it "knows if a Point is on the Board" do
    on  = MajorTom::Point.new(x: 2, y: 0)
    off = MajorTom::Point.new(x: 3, y: 0)
    expect(board).to     be_on(on)
    expect(board).not_to be_on(off)
  end

  it "lists neighbors to a passed Point" do
    points = board.neighbors(MajorTom::Point.new(x: 1, y: 1))
    expect(points.sort).to eq(
      [[1, 0], [0, 1], [2, 1]].map { |x, y| MajorTom::Point.new(x: x, y: y) }
    )
  end
end
