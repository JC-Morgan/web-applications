# POST/albums Route Design Recipe

# Request:
POST /albums

# With body parameters:
title=Voyage
release_year=2022
artist_id=2

# Expected response (200 OK)
(No content)



1. Design the Route Signature
You'll need to include:

* the HTTP method
* the path
* any query parameters (passed in the URL)
* or body parameters (passed in the request body)

Method: POST
Path: /albums
Body Parameters:
title=Voyage
release_year=2022
artist_id=2

2. Design the Response

# Create a new album
Request: POST /albums
  With body parameters: "title=Voyage, release_year=2022, artist_id=2"
Response: None (just creates the resource on the server)


3. Write Examples
Replace these with your own design.

<!-- EXAMPLE -->
<!-- Response when the post is found: 200 OK -->

<html>
  <head></head>
  <body>
    <h1>Post title</h1>
    <div>Post content</div>
  </body>
</html>
<!-- EXAMPLE -->
<!-- Response when the post is not found: 404 Not Found -->

<html>
  <head></head>
  <body>
    <h1>Sorry!</h1>
    <div>We couldn't find this post. Have a look at the homepage?</div>
  </body>
</html>

# Request:

GET /posts?id=1

# Expected response:

Response for 200 OK
# Request:

GET /posts?id=276278

# Expected response:

Response for 404 Not Found

4. Encode as Tests Examples
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "POST /albums" do
    it 'should create a new album' do
      response = get('/posts?id=1')

      expect(response.status).to eq(200)
      # expect(response.body).to eq(expected_response)
    end

    it 'returns 404 Not Found' do
      response = get('/posts?id=276278')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end
end


5. Implement the Route
Write the route and web server code to implement the route behaviour.
