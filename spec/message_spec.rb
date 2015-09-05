require_relative "../lib/major_tom/message"

describe MajorTom::Message do
  it "generates responses" do
    message  = MajorTom::Message.new(
      type: "QUERY",
      key:  "shots",
      data: ["3"]
    )
    response = message.respond(["0 0", "0 1"])
    expect(response.type).to eq("RESPONSE")
    expect(response.key).to  eq(message.key)
    expect(response.data).to eq(["0 0", "0 1"])
  end

  it "stringifies itself" do
    message = MajorTom::Message.new(
      type: "RESPONSE",
      key:  "shots",
      data: ["0 0", "0 1"]
    )
    expect(message.to_s).to eq("|RESPONSE|shots|0 0|0 1|END|")
  end

  context "parses" do
    let(:message) { MajorTom::Message.parse("|INFO|ship size|8|6|2|END|") }

    it "type" do
      expect(message.type).to eq("INFO")
    end

    it "key" do
      expect(message.key).to eq("ship size")
    end

    it "data" do
      expect(message.data).to eq(["8", "6", "2"])

      no_data = MajorTom::Message.parse("|INFO|end game|END|")
      expect(no_data.data).to eq([ ])
    end
  end
end
