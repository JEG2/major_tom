require_relative "message"

module MajorTom
  class Parser
    def initialize(stream)
      @stream   = stream
      @handlers = [ ]
    end

    attr_reader :stream, :handlers
    private     :stream, :handlers

    def add_handler(type, key, &handler)
      handlers << [type, key, handler]
    end

    def parse
      stream.each do |line|
        message = Message.parse(line)
        handlers.each do |type, key, handler|
          if type === message.type && key === message.key
            handler.call(message.data)
          end
        end
      end
    end
  end
end
