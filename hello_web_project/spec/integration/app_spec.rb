
require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do

  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET to /names" do
    it "returns 200 OK with the right content" do
      response = get("/names", names: "Julia, Mary, Karim")
      expect(response.status).to eq(200)
      expect(response.body).to eq("Julia, Mary, Karim")
    end
  end

  context "POST to /submit" do
    it "returns 200 OK with the right content" do
      response = post("/submit", name: "Dana", message: "Hi")
      expect(response.status).to eq(200)
      expect(response.body).to eq("Thanks Dana, you sent this message: Hi")
    end
  end

  context "GET to /hello" do
    it "contains a h1 title" do
      response = get("/hello", name: "Steve")
      expect(response.body).to include('<h1>Hello Steve!</h1>')
    end
  end

  context "POST to /sort-names" do
    it "returns 200 OK and list of sorted names" do
      response = post("/sort-names", names: "Joe,Alice,Zoe,Julia,Kieran")
      expect(response.status).to eq(200)
      expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
    end
  end

end
