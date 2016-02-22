# SMS Notifications
[![build Status](https://travis-ci.org/TwilioDevEd/marketing-notifications-sinatra.svg?branch=master)](https://travis-ci.org/TwilioDevEd/marketing-notifications-sinatra)

Use Twilio to create sms notifications to keep your subscribers in the loop.

## Running the application

Clone this repository and cd into the directory then.

```
$ bundle install
$ bundle exec rake createDb 
$ export TWILIO_ACCOUNT_SID=your account sid
$ export TWILIO_AUTH_TOKEN=your auth token
$ export TWILIO_NUMBER=+16515559999
$ dunble exec rake spec
$ ruby app.run
```

Then visit the application at http://localhost:4567/

In order to receive subscribers you will need to point a twilio number to the app running. To do that we can use [ngrok](https://ngrok.com/) to expose the application
to the wilder internet.

`
  ngrok http 4567
`

## Step 1. Configure your Twilio number

Go to your dashboard on [Twilio](https://www.twilio.com/user/account/phone-numbers/incoming). Click on Twilio Numbers and choose a number to setup.

On the phone number page, enter the address provided by ngrok into the _Messaging_ Request URL field.

[![Request URL](http://howtodocs.s3.amazonaws.com/setup-twilio-number.png)]

## Step 2. Wrap Up!

Now your subscribers will be able to text your new Twilio number to 'Subscribe' to your Marketing Notifications line.

Congratulations!

## Dependencies

This application uses this Twilio helper library:
* twilio-ruby

Please visit these libraries and pay your respects.
