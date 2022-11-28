# 'hello web project' Route Design Recipe

(for /names and /sort-names)

## 1. Design the Route Signature

  Method: GET
  Path: /names
  Parameters: names (name,name,name)

  Method: POST
  Path: /sort-names
  Parameters: names (name,name,name)

## 2. Design the Response

When GET /names?names=Julia, Mary, Karim
```html
Julia, Mary, Karim
```
When POST /sort-names?names=Joe,Alice,Zoe,Julia,Kieran
```html
Alice,Joe,Julia,Kieran,Zoe
```

## 3. Write Examples


```
# Request:

GET /names?names=Julia, Mary, Karim

# Expected response: (Response for 200 OK)

Julia, Mary, Karim (names)
```

```
# Request:

POST /sort-names?names=Joe,Alice,Zoe,Julia,Kieran

# Expected response: (Response for 200 OK)

Alice,Joe,Julia,Kieran,Zoe
```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /names" do
    it 'returns 200 OK and list of names' do
      response = get('/names?names=Julia, Mary, Karim')

      expect(response.status).to eq(200)
      expect(response.body).to eq("Julia, Mary, Karim")
    end
  end

  context "POST /sort-names" do
    it 'returns 200 OK and list of sorted names' do
      response = post('/sort-names?names=Joe,Alice,Zoe,Julia,Kieran')

      expect(response.status).to eq(200)
      expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
    end
  end

end
```

## 5. Implement the Route

