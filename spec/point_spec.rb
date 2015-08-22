require_relative "../lib/major_tom/point"

describe MajorTom::Point do
  it "stringifies itself" do
    point = MajorTom::Point.new(x: 0, y: 1)
    expect(point.to_s).to eq("#{point.x} #{point.y}")
  end

  it "parses coordinates" do
    point = MajorTom::Point.parse("0 1")
    expect(point.x).to eq(0)
    expect(point.y).to eq(1)
  end

  it "tests equality" do
    expect(MajorTom::Point.new(x: 0, y: 0)).to eq(
      MajorTom::Point.new(x: 0, y: 0)
    )
    expect(MajorTom::Point.new(x: 0, y: 0)).not_to eq(
      MajorTom::Point.new(x: 0, y: 1)
    )
  end

  it "have an order" do
    unordered = [[1, 1], [0, 0], [0, 1]].map { |x, y|
      MajorTom::Point.new(x: x, y: y)
    }
    ordered   = [[0, 0], [0, 1], [1, 1]].map { |x, y|
      MajorTom::Point.new(x: x, y: y)
    }
    expect(unordered.sort).to eq(ordered)
  end

  it "is safe to use in a Hash" do
    hash        = { }
    point       = MajorTom::Point.new(x: 0, y: 1)
    hash[point] = 42
    expect(hash[point.dup]).to eq(42)
  end
end
