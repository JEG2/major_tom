require_relative "../lib/major_tom/ship_placement"

describe MajorTom::ShipPlacement do
  let(:point)      { MajorTom::Point.new(x: 0, y: 1) }
  let(:horizontal) { true }
  let(:size)       { 2 }
  let(:placement)  {
    MajorTom::ShipPlacement.new(point: point, horizontal: horizontal, size: size)
  }

  it "tracks a size" do
    expect(placement.size).to eq(size)
  end

  it "tracks an alignment" do
    expect(placement.horizontal?).to   eq(horizontal)
    expect(placement.vertical?).not_to eq(horizontal)
  end

  it "lists points in the placement" do
    expect(placement.points).to eq([point, MajorTom::Point.new(x: 1, y: 1)])
  end

  it "stringifies itself" do
    expect(placement.to_s).to eq("#{placement.point} H")
  end
end
