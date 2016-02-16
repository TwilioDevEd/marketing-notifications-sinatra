require_relative '../app'
require 'rspec'
require 'rack/test'

describe 'marketing notifications' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'should be polite' do
    get '/hi'
    expect(last_response).to be_ok
  end
end
