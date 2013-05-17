require_relative '../../spec_helper'
require 'itout/client'
require 'webmock'

describe ITout::API::Streams do

  # todo: the fixture is not an authentic streams response, add one please
  it '.retrieve_stream_touts returns touts included in a stream' do
    stub_get("https://api.tout.com/api/v1/streams/fhcl57/touts").to_return(:body => fixture("featured_touts_response.json"))
    touts = ITout::Client.new.retrieve_stream_touts('fhcl57')
    expect(touts).to be_a ITout::Touts
    #expect(touts.pagination).to be_a ITout::Pagination
    touts.each do |u|
      expect(u).to be_a ITout::Tout
    end
    some_request(:get, "/streams/fhcl57/touts").should have_been_made
  end
end
