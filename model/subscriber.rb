require 'data_mapper'
require 'twilio-ruby'

class Subscriber
  include DataMapper::Resource 

  property :id, Serial
  property :phone_number, String
  property :subscribed, Boolean

  def send_message(message, image_url)
    @twilio_number = ENV['TWILIO_PHONE_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    message = @client.account.messages.create(
      :from => @twilio_number,
      :to => "+5581994596094",
      :body => message,
      :media_url => image_url
    )           
    puts message.to  
  end 
end
