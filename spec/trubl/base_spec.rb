require 'spec_helper'
require 'itout/base'

describe ITout::Base do

  subject{ ITout::Base.new }

  let(:response){ 
    resp = double("Response")
    resp.stub(:body).and_return('{"base": {}}') 
    resp
  }

  #it "" do
    #response.body.should == 'foo'
  #end

  it "inherits from Hash" do
    subject.is_a? Hash
  end

  it "inherits from Hashie::Mash" do
    subject.is_a? Hashie::Mash
  end

  describe "#from_response" do


    it "parses the response body" do
      subject.should_receive(:parse).with(response)
      subject.from_response(response)
    end

    it "uses the inferred class name" do
      subject.should_receive(:klass_name)
      subject.from_response(response)
    end

    it "re-initializes the instance" do
      subject.should_receive :initialize
      subject.from_response(response)
    end

  end

  describe "#parse" do

    it "parses the response body into a json object" do
       JSON.should_receive(:parse).with(response.body).and_return({})
       subject.parse(response)
    end

  end

  describe "klass_name" do

    it "downcases the class name " do
      subject.klass_name.should == 'base'
    end

  end

end
