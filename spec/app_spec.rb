require_relative '../app'
require 'rspec'
require 'rack/test'
require 'json'

describe 'marketing notifications' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'should be polite' do
    get '/hi'
    expect(last_response).to be_ok
  end

  it 'should respond to the contact' do
    allow(Subscriber).to receive(:all).and_return([])

    post 'subscriber', {:From => '999999999'}.to_json, 'CONTENT_TYPE' => 'application/json'

    expect(last_response).to be_ok
    expect(last_response.body).to include('Thanks')
  end

  it 'should register a new subscriber when asked' do
    subscriber = Subscriber.new('99999999')
    allow(Subscriber).to receive(:all).and_return([subscriber])

    post 'subscriber', {:From => '999999999', :Body => 'subscribe'}.to_json, 'CONTENT_TYPE' => 'application/json'

    expect(last_response).to be_ok
    expect(last_response.body).to include('subscribed')
  end

  it 'should allow to unsubscriber' do
    subscriber = Subscriber.new('99999999')
    subscriber.subscribe

    allow(Subscriber).to receive(:all).and_return([subscriber])

    post 'subscriber', {:From => '999999999', :Body => 'unsubscribe'}.to_json, 'CONTENT_TYPE' => 'application/json'

    expect(last_response).to be_ok
    expect(last_response.body).to include('unsubscribed')
  end
end
