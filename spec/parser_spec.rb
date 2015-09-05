require "stringio"

require_relative "../lib/major_tom/parser"

describe MajorTom::Parser do
  let(:stream) {
    StringIO.new("|INFO|ship size|8|6|2|END|\n|QUERY|ship locations|END|\n")
  }
  let(:parser) { MajorTom::Parser.new(stream) }

  it "reads from the passed stream" do
    expect(stream.pos).to eq(0)
    parser.parse
    expect(stream.pos).to eq(stream.string.length)
  end

  it "delivers data to handlers for matching messages" do
    data = nil
    parser.add_handler("INFO", "ship size") do |d|
      data = d
    end
    parser.parse
    expect(data).to eq(%w[8 6 2])
  end
end
