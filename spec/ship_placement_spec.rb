require_relative "../lib/major_tom/ship_placement"

describe MajorTom::ShipPlacement do
  let(:point)     { MajorTom::Point.new(x: 0, y: 1) }
  let(:alignment) { "H" }
  let(:size)      { 2 }
  let(:placement) {
    MajorTom::ShipPlacement.new(point: point, alignment: alignment, size: size)
  }

  it "tracks a size" do
    expect(placement.size).to eq(size)
  end

  it "lists points in the placement" do
    expect(placement.points).to eq([point, MajorTom::Point.new(x: 1, y: 1)])
  end

  it "stringifies itself" do
    expect(placement.to_s).to eq("#{placement.point} #{placement.alignment}")
  end
end
