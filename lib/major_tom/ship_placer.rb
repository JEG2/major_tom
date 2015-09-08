require_relative "point"
require_relative "ship_placement"

module MajorTom
  class ShipPlacer
    def initialize(width: , height: , ships: )
      @width  = width
      @height = height
      @ships  = ships
    end

    attr_reader :width, :height, :ships
    private     :width, :height, :ships

    def place
      loop do
        placements = ships.map { |ship| randomly_place(ship) }
        return placements if non_overlapping?(placements)
      end
    end

    private

    def randomly_place(ship)
      horizontal = [true, false].sample
      x, y       = horizontal ? [rand(0..(width - ship)), rand(0..height)]
                              : [rand(0..width), rand(0..(height - ship))]
      ShipPlacement.new(
        point:      Point.new(x: x, y: y),
        horizontal: horizontal,
        size:       ship
      )
    end

    def non_overlapping?(placements)
      placements.each_with_index do |placement, i|
        placements.drop(i + 1).each_with_index do |other, j|
          return false unless (placement.points & other.points).empty?
        end
      end
      true
    end
  end
end
