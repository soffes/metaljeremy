require 'digest/sha1'
require 'redis'
require 'twitter'
require 'time'

module MetalJeremy
  class Bot
    TWITTER_CONSUMER_KEY = ENV['TWITTER_CONSUMER_KEY']
    TWITTER_CONSUMER_SECRET = ENV['TWITTER_CONSUMER_SECRET']
    TWITTER_ACCESS_TOKEN = ENV['TWITTER_ACCESS_TOKEN']
    TWITTER_ACCESS_TOKEN_SECRET = ENV['TWITTER_ACCESS_TOKEN_SECRET']

    def run
      # Loops through the lines randomly
      MetalJeremy.lyrics.shuffle.each do |line|
        # Skip it if we've already tweeted it
        next if tweeted?(line)

        # Tweet and finish
        tweet! line
        return
      end
    end

    private

    def tweeted?(line)
      MetalJeremy.redis[Digest::SHA1.hexdigest(line)]
    end

    def tweet!(line)
      MetalJeremy.redis[Digest::SHA1.hexdigest(line)] = line

      if ENV['RACK_ENV'] == 'production'
        @@client ||= Twitter::REST::Client.new do |config|
          config.consumer_key = TWITTER_CONSUMER_KEY
          config.consumer_secret = TWITTER_CONSUMER_SECRET
          config.access_token = TWITTER_ACCESS_TOKEN
          config.access_token_secret = TWITTER_ACCESS_TOKEN_SECRET
        end
        @@client.update(line)
      else
        puts line
      end
    end
  end
end
