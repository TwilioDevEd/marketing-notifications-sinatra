require_relative '../app'
require 'rspec'
require 'rack/test'
require 'json'

describe 'marketing notifications' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'should respond to the contact when no message is send' do
    allow(Subscriber).to receive(:first).and_return(nil)

    post 'subscriber', {From:'999999999'}.to_json, 'CONTENT_TYPE' => 'application/json'

    expect(last_response).to be_ok
    expect(last_response.body).to include('Thanks')
  end

  it 'should respond to the contactt when message is not a valid command' do
    allow(Subscriber).to receive(:first).and_return(nil)

    post 'subscriber', {From:'999999999', Body: 'not subscribe or unsubscribe'}.to_json, 'CONTENT_TYPE' => 'application/json'

    expect(last_response).to be_ok
    expect(last_response.body).to include('Thanks')
  end

  it 'should register a new subscriber when asked' do
    subscriber = double('subscriber', update: true, subscribed: true)
    
    allow(Subscriber).to receive(:first).and_return(subscriber)

    post 'subscriber', {From:'999999999', Body: 'subscribe'}.to_json, 'CONTENT_TYPE' => 'application/json'

    expect(last_response).to be_ok
    expect(last_response.body).to include('subscribed')
  end

  it 'should allow to unsubscriber' do
    subscriber = double('subscriber', update: false, subscribed: false)
    
    allow(Subscriber).to receive(:first).and_return(subscriber)

    post 'subscriber', {From: '999999999', Body: 'unsubscribe'}.to_json, 'CONTENT_TYPE' => 'application/json'

    expect(last_response).to be_ok
    expect(last_response.body).to include('unsubscribed')
  end
end
