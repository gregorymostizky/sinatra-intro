require 'test/unit'
require 'rack/test'

Dir.glob('../lib/**.rb') do |libfile|
  require File.dirname(__FILE__) + '/' + libfile  # just load all
end

require File.dirname(__FILE__)+'/../monitor'


class MyTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Monitor
  end

  def test_default
    get '/'
    assert last_response.body =~ /Simple Monitoring Application Demo/
  end

  def test_post
    post '/report/test/ok'
    post '/report/test/ok'
    get '/'
    assert last_response.body =~ /test(.*)ok/
  end

end