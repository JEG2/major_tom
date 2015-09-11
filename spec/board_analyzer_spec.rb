require_relative "../lib/major_tom/point"
require_relative "../lib/major_tom/board"
require_relative '../lib/major_tom/board_analyzer'

describe MajorTom::BoardAnalyzer do

  let(:board) { MajorTom::Board.new(width: 3, height: 2, ships: [], ) }

  it 'tracks if it has hits to be processed' do
    analyzer = MajorTom::BoardAnalyzer.new(board)
    expect(analyzer.new_hits?).to be(false)

    hit   = MajorTom::Point.new(x:1,y:1)
    board.record_hit(hit)

    expect(analyzer.new_hits?).to be(true)
  end

  it 'can pop hits from the queue' do
    hit  = MajorTom::Point.new(x:1,y:1)
    hit2 = MajorTom::Point.new(x:1,y:2)
    analyzer = MajorTom::BoardAnalyzer.new(board)
    board.record_hit(hit)
    board.record_hit(hit2)

    expect(analyzer.pop_hit).to eq(hit)
    expect(analyzer.pop_hit).to eq(hit2)
    expect(analyzer.pop_hit).to eq(nil)
  end

end
