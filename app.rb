require 'sinatra'
require 'data_mapper'
require 'json'
require 'rack/contrib'
require_relative 'model/subscriber'

DataMapper.setup(:default, 'postgres://postgres:postgres@localhost/marketing_notifications')
DataMapper.finalize
Subscriber.auto_upgrade!

use ::Rack::PostBodyContentTypeParser

SUBSCRIPTION_MESSAGE = 'You are now subscribed for updates.'
UNSUBSCRIPTION_MESSAGE = "You have unsubscribed from notifications. Test 'add' to start receieving updates again"
INSTRUCTIONS_MESSAGE = "Thanks for contacting TWBC! Text 'add' if you would to receive updates via text message." 

get '/' do
  erb :index, locals: {message: nil}
end

post '/messages' do
  Subscriber.all.each do |subscriber|
    subscriber.send_message(params['message'], params['image_url'])
  end

  erb :index, locals: {message: 'Messages Sent!!!'}
end

post '/subscriber' do
  if is_valid(params[:Body])
    subscriber = create_or_update_subscriber(params)
    subscriber.subscribed ? format_message(SUBSCRIPTION_MESSAGE) : format_message(UNSUBSCRIPTION_MESSAGE)
  else
    format_message(INSTRUCTIONS_MESSAGE)
  end
end

def is_subscription(command)
  command == 'add'
end

def is_valid(command)
  command == 'add' or command == 'remove'
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
