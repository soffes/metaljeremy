require 'redis'

module MetalJeremy
  module_function

  def redis
    @@redis ||= begin
      uri = URI.parse(ENV['REDIS_URL'] || 'redis://localhost:6379')
      Redis.new(host: uri.host, port: uri.port, password: uri.password)
    end
  end

  def lyrics
    @@lyrics ||= File.read(File.expand_path('../metal_jeremy/lyrics.txt', __FILE__)).split("\n")
  end
end

require 'metal_jeremy/bot'
require 'metal_jeremy/application'
