require 'data_mapper'
require 'twilio-ruby'

class Subscriber
  include DataMapper::Resource

  property :id, Serial
  property :phone_number, String
  property :subscribed, Boolean

  def send_message(message, media_url=nil)
    @client = Twilio::REST::Client.new(
      ENV['TWILIO_ACCOUNT_SID'],
      ENV['TWILIO_AUTH_TOKEN']
    )
    if media_url.nil? || media_url.empty?
      @client.account.messages.create(
        from: ENV['TWILIO_PHONE_NUMBER'],
        to: phone_number,
        body: message
      )
    else
      @client.account.messages.create(
        from: ENV['TWILIO_PHONE_NUMBER'],
        to: phone_number,
        body: message,
        media_url: media_url
      )
    end
  end

  def self.subscribed 
    all(subscribed: true)
  end
end
