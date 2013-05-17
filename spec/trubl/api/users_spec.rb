require_relative '../../spec_helper'
require 'itout/client'
require 'webmock'

describe ITout::API::Users do

  it '.retrieve_user returns a ITout::User' do
    stub_get("https://api.tout.com/api/v1/users/karmin").to_return(:body => fixture("user.json"))
    user = ITout::Client.new.retrieve_user("karmin")
    expect(user).to be_a ITout::User
    expect(user.uid).to eq("karmin")
    some_request(:get, "/api/v1/users/karmin").should have_been_made
  end

  it '.retrieve_user_likes returns a Collection of Touts liked by the specified user' do
    stub_get("https://api.tout.com/api/v1/users/karmin/likes").to_return(:body => fixture("touts_liked_by_user_response.json"))
    touts = ITout::Client.new.retrieve_user_likes("karmin")
    expect(touts).to be_a ITout::Touts
    #expect(touts.pagination).to be_a ITout::Pagination
    touts.each do |u|
      expect(u).to be_a ITout::Tout
    end
    some_request(:get, "/api/v1/users/karmin/likes").should have_been_made
  end

  it '.retrieve_user_touts returns a Collection of Touts created by the specified user' do
    stub_get("https://api.tout.com/api/v1/users/teamtout/touts").to_return(:body => fixture("user_touts_response.json"))
    touts = ITout::Client.new.retrieve_user_touts("teamtout")
    expect(touts).to be_a ITout::Touts
    #expect(touts.pagination).to be_a ITout::Pagination
    touts.each do |u|
      expect(u).to be_a ITout::Tout
    end
    some_request(:get, "/api/v1/users/teamtout/touts").should have_been_made
  end

  it '.retrieve_user_followers returns the Users following the specified user' do
    stub_get("https://api.tout.com/api/v1/users/teamtout/followers").to_return(:body => fixture("user_followers.json"))
    users = ITout::Client.new.retrieve_user_followers("teamtout")
    expect(users).to be_a ITout::Users
    #expect(users.pagination).to be_a ITout::Pagination
    users.each do |u|
      expect(u).to be_a ITout::User
    end
    some_request(:get, "/api/v1/users/teamtout/followers").should have_been_made
  end

  it '.follow_user executes a follow for the specified user with a user authed token' do
    client = ITout::Client.new
    stub_post("https://api.tout.com/api/v1/users/teamtout/follow").to_return(:body => "")
    client.follow_user('teamtout')
    some_request(:post, "/api/v1/users/teamtout/follow").should have_been_made
  end

end
