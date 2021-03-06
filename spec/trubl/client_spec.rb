require_relative "../spec_helper"
require "itout/client"

describe ITout::Client do

  it "instantiates a new ITout::Client instance" do
    expect(ITout::Client.new()).to be_a ITout::Client
  end

  describe ".auth" do
    it "stores access_token" do
      body = "client_id=&client_secret=&grant_type=client_credentials"
      headers = {'Accept'=>'application/json', 'Authorization'=>'Bearer', 'Connection'=>'keep-alive'}
      stub_post("https://www.tout.com/oauth/token").with(body: body, headers: headers).to_return(body: fixture("client1_auth_resp.json"))
      client = ITout::Client.new()
      client.client_auth()
      expect(client.access_token).to eq "6bffd46fca32a9dc640a7f2284edd55b5175d59323923f984b92ee5ec6a0a9e4"
    end
  end

  describe ".credentials" do
    it "returns a hash of creds" do
      body = "client_id=client_id&client_secret=client_sekrit&grant_type=client_credentials"
      headers = {'Accept'=>'application/json', 'Authorization'=>'Bearer', 'Connection'=>'keep-alive'}
      stub_post("https://www.tout.com/oauth/token").with(body: body, headers: headers).to_return(body: fixture("client1_auth_resp.json"))
      client = ITout::Client.new("client_id", "client_sekrit")
      client.client_auth()
      expect(client.credentials).to eq({client_id:"client_id", client_secret:"client_sekrit", access_token:"6bffd46fca32a9dc640a7f2284edd55b5175d59323923f984b92ee5ec6a0a9e4"})

    end
  end

  describe ".api_uri_root" do
    it "is the correct base endpoint" do
      client = ITout::Client.new()
      expect(client.api_uri_root).to eq("https://api.tout.com/api/v1/")
    end
  end

  describe ".delete" do
    it "processes a delete" do
      path = "toutitout"
      client = ITout::Client.new()
      stub_delete(path).to_return(:status => 200, :body => "", :headers => {})
      client.delete(path)
      some_request(:delete, path).should have_been_made
    end
  end

  describe ".post" do
    it "processes a post" do
      path = "toutitout"
      client = ITout::Client.new()
      stub_post(path).to_return(:status => 200, :body => "", :headers => {})
      client.post(path)
      some_request(:post, path).should have_been_made
    end
  end

  describe ".get" do
    it "processes a get" do
      path = "toutitout"
      client = ITout::Client.new()
      stub_get(path).to_return(:status => 200, :body => "", :headers => {})
      client.get(path)
      some_request(:get, path).should have_been_made
    end
  end

  describe ".put" do
    it "processes a put" do
      path = "toutitout"
      client = ITout::Client.new()
      stub_put(path).to_return(:status => 200, :body => "", :headers => {})
      client.put(path)
      some_request(:put, path).should have_been_made
    end
  end

end
