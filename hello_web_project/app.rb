require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
end

class Application
  get '/' do
    "Hello World"
  end
end
