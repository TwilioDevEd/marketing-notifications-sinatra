require 'sinatra'
require 'data_mapper'
require 'json'
require 'rack/contrib'
require 'twilio-ruby'

DataMapper.setup(:default, 'postgres://postgres:@localhost/marketing_notifications')

class Subscriber
  include DataMapper::Resource 

  property :id, Serial
  property :phone_number, String
  property :subscribed, Boolean

end

DataMapper.finalize

Subscriber.auto_upgrade!

use ::Rack::PostBodyContentTypeParser

get '/hi' do
  'hello world'
end

post '/subscriber' do
  if params[:Body]
    subscriber = create_or_update_subscriber(params)
    subscription_message = 'You are now subscribed for updates.'
    unsubscritpion_message = "You have unsubscribed from notifications. Test 'subscribe' to start receieving updates again"
    subscriber.subscribed ? format_message(subscription_message) : format_message(unsubscritpion_message)
  else
    "Thanks for contacting TWBC! Text 'subscribe' if you would to receive updates via text message."
  end
end

def is_subscription(command)
  command == 'subscribe'
end

def format_message(message)
  response = Twilio::TwiML::Response.new do |r|
    r.Message message
  end
  response.text
end

def create_or_update_subscriber(params)
  subscriber = Subscriber.first(:phone_number => params[:From])
  if subscriber
    subscriber.update(:subscribed => is_subscription(params[:Body]))
    subscriber
  else
    Subscriber.create(:phone_number => params[:From], :subscribed => is_subscription(params[:Body]))
  end
end
