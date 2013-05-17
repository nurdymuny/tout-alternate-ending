
require 'spec_helper'
require 'itout/channel'

describe ITout::Channel do
  # this is the silly namespace one
  # this is also an example of the simple OpenStruct usage, to be replaced eventually

  let(:channel_uid){"new-york-fashion-week"}

  it "magically creates a Tout object from json" do
    channel = ITout::Channel.new(json_fixture("channel_response.json")["channel"])
    expect(channel.uid).to eq(channel_uid)
  end

end
