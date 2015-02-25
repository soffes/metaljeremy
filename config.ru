require 'rubygems'
require 'bundler'
Bundler.require

require 'rack-canonical-host'
use Rack::CanonicalHost, ENV['CANONICAL_HOST'] if ENV['CANONICAL_HOST']

$LOAD_PATH.unshift 'lib'
require 'metal_jeremy'
run MetalJeremy::Application
