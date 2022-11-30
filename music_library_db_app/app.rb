
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all
    return erb(:albums)
  end

  get '/albums/new' do
    return erb(:album_add)
  end

  get '/albums/:id' do

    id = params[:id]
    repo_alb = AlbumRepository.new
    repo_art = ArtistRepository.new

    album = repo_alb.find(id)
    @title = album.title
    @release_year = album.release_year
    artist_id = album.artist_id

    artist = repo_art.find(artist_id)
    @name = artist.name

    return erb(:albums_id)

  end

  def invalid_request_parameters_alb?
    params[:title] == nil || params[:release_year] == nil || params[:artist_id] == nil
  end

  post '/albums' do

    repo = AlbumRepository.new
    new_album = Album.new
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]
    if invalid_request_parameters_alb?
      status 400
      return ""
    end
    repo.create(new_album)

    return erb(:add_success)
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all
    return erb(:artists)
  end

  get '/artists/new' do
    return erb(:artist_add)
  end

  get '/artists/:id' do

    id = params[:id]
    repo = ArtistRepository.new

    artist = repo.find(id)

    @name = artist.name
    @genre = artist.genre

    return erb(:artists_id)

  end

  def invalid_request_parameters_art?
    params[:name] == nil || params[:genre] == nil
  end

  post '/artists' do

    repo = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = params[:name]
    new_artist.genre = params[:genre]
    if invalid_request_parameters_art?
      status 400
      return ""
    end
    repo.create(new_artist)

    return erb(:add_success)
  end

end
