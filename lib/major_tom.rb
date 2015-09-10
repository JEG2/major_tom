require_relative "major_tom/parser"
require_relative "major_tom/board"
require_relative "major_tom/point"
require_relative "major_tom/ship_placer"
require_relative "major_tom/ai"

module MajorTom
  module_function

  def play(input: , output: )
    parser = Parser.new(input)

    board         = nil
    board_details = { }
    parser.add_handler(type: "INFO", key: "grid size") do |info|
      width, height = info.data.first.split.map(&:to_i)
      board_details.merge!(width: width, height: height)
    end
    parser.add_handler(type: "INFO", key: "ship sizes") do |info|
      board_details.merge!(ships: info.data.map(&:to_i))
      board = Board.new(board_details)
    end

    parser.add_handler(type: "INFO", key: /\Ayou (?:miss|hit)\z/) do |info|
      method, point = "record_#{info.key[/\w+\z/]}", Point.parse(info.data.first)
      board.public_send(method, point)
    end

    parser.add_handler(type: "QUERY", key: "ship locations") do |query|
      placements = ShipPlacer.new(board_details).place
      output.puts query.respond(placements)
    end
    ai = AI.new(board)
    parser.add_handler(type: "QUERY", key: "shots") do |query|
      shots = ai.shots(query.data.first.to_i)
      output.puts query.respond(shots)
    end

    parser.parse
  end
end
