require_relative "../lib/major_tom/ship_placer"

describe MajorTom::ShipPlacer do
  it "generates a placement for each ship" do
    ships      = Array.new(rand(1..5)) { rand(2..5) }
    placements = MajorTom::ShipPlacer.new(width: 10, height: 10, ships: ships)
    expect(placements.place.size).to eq(ships.size)
  end

  context "verified" do
    let(:width)      { 5 }
    let(:height)     { 5 }
    let(:ships)      { [2, 3, 3, 4, 5] }
    let(:placements) {
      MajorTom::ShipPlacer.new(width: width, height: height, ships: ships).place
    }

    it "places on the board" do
      placements.each do |placement|
        if placement.alignment == "H"
          expect(placement.point.x).to be_between(0, width - placement.size)
          expect(placement.point.y).to be_between(0, height)
        else
          expect(placement.point.x).to be_between(0, width)
          expect(placement.point.y).to be_between(0, height - placement.size)
        end
      end
    end

    it "places without overlap" do
      points = { }
      placements.each do |placement|
        placement.points.each do |point|
          points[point] = true
        end
      end
      expect(points.size).to eq(ships.inject(:+))
    end
  end
end
