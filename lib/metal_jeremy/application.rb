require 'sinatra'

module MetalJeremy
  class Application < Sinatra::Base
    get '/' do
      redirect 'https://twitter.com/ageofjeremy'
    end
  end
end
