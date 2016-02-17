require 'sinatra'
require 'data_mapper'
require 'json'
require 'rack/contrib'

DataMapper.setup(:default, 'postgres://postgres:@localhost/marketing_notifications')

class Subscriber
  include DataMapper::Resource 

  property :id, Serial
  property :phone_number, String

  def initialize(phone_number)
    @phone_number = phone_number
  end

  def subscribe
    @subscribed = true
  end
end

DataMapper.finalize

Subscriber.auto_upgrade!

use ::Rack::PostBodyContentTypeParser

get '/hi' do
  'hello world'
end

post '/subscriber' do
  if params['Body'] == 'subscribe'
    'subscribed'
  elsif params['Body'] == 'unsubscribe'
    'unsubscribed'
  else
    "Thanks for contacting TWBC! Text 'subscribe' if you would to receive updates via text message."
  end
end
