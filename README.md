# SMS Notifications
[![build Status](https://travis-ci.org/TwilioDevEd/marketing-notifications-sinatra.svg?branch=master)](https://travis-ci.org/TwilioDevEd/marketing-notifications-sinatra)

Use Twilio to create SMS notifications to keep your subscribers in the loop.

[Read the full tutorial here](https://www.twilio.com/docs/tutorials/walkthrough/server-notifications/ruby/sinatra)!

## Running the application

#### Step 1. First clone this repository and `cd` into it
```
git clone git@github.com:TwilioDevEd/marketing-notifications-sinatra.git
cd marketing-notifications-sinatra
```

#### Step 2. Install dependencies
```
bundle
```

#### Step 3. Export environment variables

You can find `AccountSID` and the `AuthToken` at [https://www.twilio.com/user/account/settings](https://www.twilio.com/user/account/settings).
```
export TWILIO_ACCOUNT_SID=your account sid
export TWILIO_AUTH_TOKEN=your auth token
export TWILIO_NUMBER=your twilio number
```

#### Step 4. Create application database

Make sure you have installed [PostgreSQL](http://www.postgresql.org/). If on a Mac, I recommend [Postgres.app](http://postgresapp.com). Given that, we'll use a rake task to generate the database used by the app. You just need to provide a valid user with permission to create databases.

```
bundle exec rake db:create[user_name]
```

#### Step 5. Make sure the tests succeed

```
bundle exec rake spec
```

#### Step 6. Run the server

```
bundle exec ruby app.rb
```

#### Step 7. Expose application to the wider internet

We can use [ngrok](https://ngrok.com/) for this purpose.

```
  ngrok http 4567
```

#### Step 8. Configure your Twilio number

Go to your dashboard on [Twilio](https://www.twilio.com/user/account/phone-numbers/incoming). Click on Twilio Numbers and choose a number to setup.
On the phone number page enter the address provided by ngrok into the _Messaging_ Request URL field.

![Request URL](http://howtodocs.s3.amazonaws.com/setup-twilio-number.png)

#### Step 9. Wrap Up!

By now your application should be up and running at [http://localhost:4567/](http://localhost:4567). Now your subscribers will be able to
text your new Twilio number to Subscribe to your Marketing Notifications Service.

Congratulations!

## Dependencies

This application uses this Twilio helper library:
* twilio-ruby

---------------
<a href="http://twilio.com/signal">![](https://s3.amazonaws.com/baugues/signal-logo.png)</a>

Join us in San Francisco May 24-25th to [learn best practices from the engineers who create the Twilio stack](https://www.twilio.com/signal). 

