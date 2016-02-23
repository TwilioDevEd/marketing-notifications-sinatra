require 'data_mapper'
require 'twilio-ruby'

class Subscriber
  include DataMapper::Resource

  property :id, Serial
  property :phone_number, String
  property :subscribed, Boolean

  def send_message(message, image_url)
    @client = Twilio::REST::Client.new(
      ENV['TWILIO_ACCOUNT_SID'],
      ENV['TWILIO_AUTH_TOKEN']
    )
    @client.account.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: phone_number,
      body: message,
      media_url: image_url
    )
  end

  def self.subscribed 
    all(subscribed: true)
  end
end
