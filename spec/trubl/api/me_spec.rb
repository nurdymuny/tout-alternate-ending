require 'itout/client'

describe ITout::API::Me do

  it "retrieve_me returns my ITout::User" do
    stub_get("https://api.tout.com/api/v1/me").to_return(:body => fixture("retrieve_me_response.json"))
    user = ITout::Client.new.get_me()
    expect(user).to be_a ITout::User
    some_request(:get, "/api/v1/me").should have_been_made
  end

  it ".get_my_fb_sharing_settings returns json rep of fb settings" do
    stub_get("https://api.tout.com/api/v1/me/sharing/facebook").to_return(:body => fixture("me_fb_sharing_response.json"))
    json = ITout::Client.new.get_my_fb_sharing_settings
    expect(json).to be_a Hash
    expect(json["via"]["name"]).to eq("Facebook")
  end

  it ".get_my_touts returns Touts instance" do
    stub_get("https://api.tout.com/api/v1/me/touts").to_return(:body => fixture("me_retrieve_user_touts_response.json"))
    touts = ITout::Client.new.get_my_touts()
    expect(touts).to be_a ITout::Touts
    some_request(:get, "/api/v1/me/touts").should have_been_made
  end

  it ".get_my_liked_touts returns Touts instance" do
    stub_get("https://api.tout.com/api/v1/me/likes").to_return(:body => fixture("me_retrieve_user_liked_touts_response.json"))
    touts = ITout::Client.new.get_my_liked_touts()
    expect(touts).to be_a ITout::Touts
    some_request(:get, "/api/v1/me/likes").should have_been_made
  end

  it ".friends returns Users instance" do
    stub_get("https://api.tout.com/api/v1/me/friends").to_return(:body => fixture("me_friends_response.json"))
    users = ITout::Client.new.friends()
    expect(users).to be_a ITout::Users
    some_request(:get, "/api/v1/me/friends").should have_been_made
  end

end