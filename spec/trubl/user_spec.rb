require_relative "../spec_helper"
require "itout/user"

describe ITout::User do
  # this is the silly namespace one
  # this is also an example of the simple OpenStruct usage, to be replaced eventually

  it "magically creates a Tout object from json" do
    user = ITout::User.new(json_fixture("user.json")["user"])
    expect(user.uid).to eq("karmin")
  end

  it ".like is a usable verb when created via a client" do
    stub_get("https://api.tout.com/api/v1/users/karmin").to_return(:body => fixture("user.json"))
    user = ITout::Client.new.retrieve_user("karmin")
    stub_get("https://api.tout.com/api/v1/users/karmin/likes").to_return(:body => fixture("touts_liked_by_user_response.json"))
    touts = user.likes
    #expect(touts.pagination).to be_a ITout::Pagination
    touts.each do |u|
      expect(u).to be_a ITout::Tout
    end
    some_request(:get, "/api/v1/users/karmin/likes").should have_been_made
  end

  it ".likes is a usable verb when created via a client" do
    stub_get("https://api.tout.com/api/v1/users/karmin").to_return(:body => fixture("user.json"))
    user = ITout::Client.new.retrieve_user("karmin")
    stub_get("https://api.tout.com/api/v1/users/karmin/touts").to_return(:body => fixture("user_touts_response.json"))
    touts = user.touts
    expect(touts).to be_a ITout::Touts
    #expect(touts.pagination).to be_a ITout::Pagination
    touts.each do |u|
      expect(u).to be_a ITout::Tout
    end
    some_request(:get, "/api/v1/users/karmin/touts").should have_been_made
  end

  it ".followers is a usable verb when created via a client" do
    stub_get("https://api.tout.com/api/v1/users/karmin").to_return(:body => fixture("user.json"))
    user = ITout::Client.new.retrieve_user("karmin")
    stub_get("https://api.tout.com/api/v1/users/karmin/followers").to_return(:body => fixture("user_followers.json"))
    users = user                                  .followers
    expect(users).to be_a ITout::Users
    #expect(users.pagination).to be_a ITout::Pagination
    users.each do |u|
      expect(u).to be_a ITout::User
    end
    some_request(:get, "/api/v1/users/karmin/followers").should have_been_made
  end

end