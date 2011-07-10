require 'bundler/setup'
Bundler.require

Dir.glob('lib/**.rb') do |libfile|
  require File.dirname(__FILE__) + '/' + libfile  # just load all
end

require File.dirname(__FILE__) + '/monitor'

run Monitor.new