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
    message_params = {
      from: ENV['TWILIO_NUMBER'],
      to: phone_number,
      body: message,
    }

    message_params.merge(media_url: media_url) unless media_url.nil? || media_url.empty?
    @client.account.messages.create(message_params)
  end

  def self.subscribed
    all(subscribed: true)
  end
end
