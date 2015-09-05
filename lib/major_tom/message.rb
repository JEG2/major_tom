module MajorTom
  class Message
    def self.parse(string)
      type, key, *data = string.sub(/\|(.+)\|END\|\s*/, '\1').split("|")
      new(type: type, key: key, data: data)
    end

    def initialize(type: , key: , data: [ ])
      @type = type
      @key  = key
      @data = data
    end

    attr_reader :type, :key, :data

    def respond(new_data = [ ])
      self.class.new(type: "RESPONSE", key: key, data: new_data)
    end

    def to_s
      "|#{[type, key, *data].join('|')}|END|"
    end
  end
end
