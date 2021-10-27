<a href="https://www.twilio.com">
  <img src="https://static0.twilio.com/marketing/bundles/marketing/img/logos/wordmark-red.svg" alt="Twilio" width="250" />
</a>

# SMS Notifications with Twilio, Ruby and Sinatra

[![Build and test](https://github.com/TwilioDevEd/marketing-notifications-sinatra/actions/workflows/build_test.yml/badge.svg)](https://github.com/TwilioDevEd/marketing-notifications-sinatra/actions/workflows/build_test.yml)

Use Twilio to create SMS notifications to keep your subscribers in the loop.

[Read the full tutorial here](https://www.twilio.com/docs/tutorials/walkthrough/marketing-notifications/ruby/sinatra)!

## Get started

This project is built using [Sinatra](http://www.sinatrarb.com/) Framework.


1. First clone this repository and `cd` into it.

   ```bash
   git clone git@github.com:TwilioDevEd/marketing-notifications-sinatra.git
   cd marketing-notifications-sinatra
   ```

1. Install dependencies.

   ```bash
   bundle
   ```

1. Copy the `.env.example` file to `.env`, and edit it including your credentials
   for the Twilio API (found at https://www.twilio.com/console/account/settings).
   You will also need a [Twilio Number](https://www.twilio.com/console/phone-numbers/incoming).

1. Create application database.

   Make sure you have installed [PostgreSQL](http://www.postgresql.org/). If on a Mac, I recommend [Postgres.app](http://postgresapp.com). Given that, we'll use a rake task to generate the database used by the app. You just need to provide a valid user with permission to create databases.

   ```bash
   bundle exec rake db:create[user_name]
   ```

1. Make sure the tests succeed.

   ```bash
   bundle exec rake spec
   ```

1. Run the server.

   ```
   bundle exec ruby app.rb
   ```

1. Expose application to the wider internet.

   We can use [ngrok](https://ngrok.com/) for this purpose.

   ```bash
   ngrok http 4567
   ```

1. Configure your Twilio number.

   Go to your dashboard on [Twilio](https://www.twilio.com/user/account/phone-numbers/incoming). Click on Twilio Numbers and choose a number to setup.
   On the phone number page enter the address provided by ngrok into the _Messaging_ Request URL field. It should be something like this:

   ```
   http://9a159ccf.ngrok.io/subscriber
   ```

   ![Request URL](http://howtodocs.s3.amazonaws.com/setup-twilio-number.png)

1. Check it out at [`http://localhost:4567`](http://localhost:4567).

### Configure Development vs Production Settings

By default, this application will run in production mode - stack traces will not be visible in the web browser. If you would like to run this application in development locally, change the `APP_ENV` variable in your `.env` file.

`APP_ENV=development`

For more about development vs production, visit [Sinatra's configuration page](http://sinatrarb.com/configuration.html).

## Meta

* No warranty expressed or implied. Software is as is. Diggity.
* [MIT License](http://www.opensource.org/licenses/mit-license.html)
* Lovingly crafted by Twilio Developer Education.
