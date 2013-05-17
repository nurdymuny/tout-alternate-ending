require 'spec_helper'
require 'itout'

describe ITout do
  describe ".client initialization" do

    it "returns a ITout::Client" do
      expect(ITout.client).to be_a ITout::Client
    end

    it "ITout::Client has nil credentials" do
      expect(ITout.client.credentials).to eq({client_id:'', client_secret:'', access_token:nil})
    end

    it "is in fact a new client when instantiating a new instance" do
      client1 = ITout.client("client1", "sekrit1")
      expect(client1.client_id).to eq("client1")
      client2 = ITout.client("client2", "sekrit2")
      expect(client2.client_id).to eq("client2")
    end

  end
end