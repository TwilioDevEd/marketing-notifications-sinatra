require_relative '../app'
require 'rspec'
require 'rack/test'
require 'json'

describe 'marketing notifications' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'informs the contact when no message is send' do
    allow(Subscriber).to receive(:first).and_return(nil)

    post 'subscriber', { From: '999999999' }.to_json,
         'CONTENT_TYPE' => 'application/json'

    expect(last_response).to be_ok
    expect(last_response.body).to include('Thanks')
  end

  it 'informs the contact when message is not a valid command' do
    allow(Subscriber).to receive(:first).and_return(nil)

    post 'subscriber',
         { From: '999999999', Body: 'not add or remove' }.to_json,
         'CONTENT_TYPE' => 'application/json'

    expect(last_response).to be_ok
    expect(last_response.body).to include('Thanks')
  end

  it 'registers a new subscriber when asked' do
    subscriber = double('subscriber', update: true, subscribed: true)
    allow(Subscriber).to receive(:first).and_return(subscriber)

    post 'subscriber', { From: '999999999', Body: 'add' }.to_json,
         'CONTENT_TYPE' => 'application/json'

    expect(last_response).to be_ok
    expect(last_response.body).to include('subscribed')
  end

  it 'allows to unsubscribe' do
    subscriber = double('subscriber', update: false, subscribed: false)
    allow(Subscriber).to receive(:first).and_return(subscriber)

    post 'subscriber', { From: '999999999', Body: 'remove' }.to_json,
         'CONTENT_TYPE' => 'application/json'

    expect(last_response).to be_ok
    expect(last_response.body).to include('unsubscribed')
  end

  it 'sends messages to all subscribers' do
    subscriber = double('subscriber')
    allow(Subscriber).to receive(:all).and_return([subscriber])
    expect(subscriber).to receive(:send_message)
      .with('just a test message', 'image.url')
    post 'messages',
         { message: 'just a test message', image_url: 'image.url' }.to_json,
         'CONTENT_TYPE' => 'application/json'
  end
end
