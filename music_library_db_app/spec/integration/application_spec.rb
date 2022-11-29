require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  def reset_artists_table
    seed_sql = File.read('spec/seeds/artists_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  def reset_albums_table
    seed_sql = File.read('spec/seeds/albums_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_artists_table
    reset_albums_table
  end

  context "GET/ albums" do
    it "should return the list of albums" do
      response = get('/albums')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Albums</h1>')
      expect(response.body).to include('<a href="/albums/1">Doolittle</a>')
      expect(response.body).to include('<a href="/albums/2">Surfer Rosa</a>')
      expect(response.body).to include('<a href="/albums/3">Waterloo</a>')
      expect(response.body).to include('<a href="/albums/12">Ring Ring</a>')
    end

    it "returns the 1st album in the list when /id = /1" do
      response = get("/albums/1")
      expect(response.status).to eq 200
      expect(response.body).to include '<h1>Doolittle</h1>'
      expect(response.body).to include '<p>
      Release year: 1989
      Artist: Pixies
    </p>'
    end

    it "returns the 2nd album in the list when /id = /2" do
      response = get("/albums/2")
      expect(response.status).to eq 200
      expect(response.body).to include '<h1>Surfer Rosa</h1>'
      expect(response.body).to include '<p>
      Release year: 1988
      Artist: Pixies
    </p>'
    end
  end

  context "POST/ albums" do
    it "should create a new album" do
      response = post(
        "/albums",
        title: "Voyage",
        release_year: "2022",
        artist_id: "2"
      )

      expect(response.status).to eq(200)
      expect(response.body).to include('')

      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include('Voyage')
    end
  end

  context "GET/ artists" do
    it "should return the list of artists" do
      response = get('/artists')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Artists</h1>')
      expect(response.body).to include('<a href="/artists/1">Pixies</a>')
      expect(response.body).to include('<a href="/artists/2">ABBA</a>')
      expect(response.body).to include('<a href="/artists/3">Taylor Swift</a>')
    end

    it "returns the 1st artist in the list when /id = /1" do
      response = get("/artists/1")
      expect(response.status).to eq 200
      expect(response.body).to include '<h1>Pixies</h1>'
      expect(response.body).to include '<p>
      Genre: Rock
    </p>'
    end

    it "returns the 2nd artist in the list when /id = /2" do
      response = get("/artists/2")
      expect(response.status).to eq 200
      expect(response.body).to include '<h1>ABBA</h1>'
      expect(response.body).to include '<p>
      Genre: Pop
    </p>'
    end
  end

  context "POST/ artists" do
    it "should create a new artist" do
      response = post(
        "/artists",
        name: "Imagine Dragons",
        genre: "Pop Rock"
      )

      expect(response.status).to eq(200)
      expect(response.body).to include('')

      response = get('/artists')

      expect(response.status).to eq(200)
      expect(response.body).to include('Imagine Dragons')
    end
  end

end

