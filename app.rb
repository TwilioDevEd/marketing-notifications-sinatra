require 'sinatra'
require 'data_mapper'
require 'json'
require 'rack/contrib'
require 'tilt/erb'
require_relative 'model/subscriber'

database_url = 'postgres://postgres:postgres@localhost/marketing_notifications'
DataMapper.setup(:default, database_url)
DataMapper.finalize
Subscriber.auto_upgrade!

use ::Rack::PostBodyContentTypeParser

SUBSCRIPTION_MESSAGE = 'You are now subscribed for updates.'.freeze
UNSUBSCRIPTION_MESSAGE = %(
  You have unsubscribed from notifications.
  Test 'add' to start receiving updates again.
)
INSTRUCTIONS_MESSAGE = %(
  Thanks for contacting TWBC!
  Text 'add' if you would to receive updates via text message.
)

get '/' do
  erb :index, locals: { message: nil }
end

post '/messages' do
  Subscriber.all(subscribed: true).each do |subscriber|
    subscriber.send_message(params['message'], params['image_url'])
  end

  erb :index, locals: { message: 'Messages Sent!!!' }
end

post '/subscriber' do
  command = params[:Body]
  if valid_command?(command)
    subscriber = create_or_update_subscriber(params)

    if subscriber.subscribed
      format_message(SUBSCRIPTION_MESSAGE)
    else
      format_message(UNSUBSCRIPTION_MESSAGE)
    end
  else
    format_message(INSTRUCTIONS_MESSAGE)
  end
end

def subscription?(command)
  command == 'add'
end

def valid_command?(command)
  command == 'add' || command == 'remove'
end

def format_message(message)
  response = Twilio::TwiML::Response.new do |r|
    r.Message message
  end
  response.text
end

def create_or_update_subscriber(params)
  subscriber = Subscriber.first(phone_number: params[:From])
  if subscriber
    subscriber.update(subscribed: subscription?(params[:Body]))
    subscriber
  else
    Subscriber.create(
      phone_number: params[:From],
      subscribed: subscription?(params[:Body])
    )
  end
end
