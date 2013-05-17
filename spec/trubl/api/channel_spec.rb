require_relative '../../spec_helper'
require 'itout/client'
require 'webmock'

describe ITout::API::Channel do

  let(:channel_uid){"new-york-fashion-week"}

  it '.retrieve_channel parses a channel response correctly' do
    stub_api_get("channels/#{channel_uid}").to_return(:body => fixture("channel_response.json"))
    channel = ITout::Client.new.retrieve_channel(channel_uid)
    expect(channel).to be_a ITout::Channel
    expect(channel.uid).to eq(channel_uid)
    api_get_request("channels/#{channel_uid}").should have_been_made
  end

  it '.retrieve_channel_users parses channel users correctly' do
    stub_api_get("channels/#{channel_uid}/users").to_return(:body => fixture("channel_users_response.json"))
    users = ITout::Client.new.retrieve_channel_users(channel_uid)
    expect(users).to be_a ITout::Users
    #expect(users.pagination).to be_a ITout::Pagination
    users.each do |u|
      expect(u).to be_a ITout::User
    end
    api_get_request("channels/#{channel_uid}/users").should have_been_made
  end

  it '.retrieve_channel_touts parses channel touts correctly' do
    stub_api_get("channels/#{channel_uid}/touts").to_return(:body => fixture("channel_touts_response.json"))
    touts = ITout::Client.new.retrieve_channel_touts(channel_uid)
    expect(touts).to be_a ITout::Touts
    #expect(touts.pagination).to be_a ITout::Pagination
    touts.each do |u|
      expect(u).to be_a ITout::Tout
    end
    api_get_request("channels/#{channel_uid}/touts").should have_been_made
  end

end
