[![Code Climate](https://codeclimate.com/github/jason-hobbs/starter_bootstrap/badges/gpa.svg)](https://codeclimate.com/github/jason-hobbs/starter_bootstrap) [![Test Coverage](https://codeclimate.com/github/jason-hobbs/starter_bootstrap/badges/coverage.svg)](https://codeclimate.com/github/jason-hobbs/starter_bootstrap/coverage)

###Starter_Bootstrap

This is a starter site for Ruby on Rails apps.
It has bootstrap, gritter notifications, postgresql, gravatar, and an authentication system built in.
[Demo here](https://starter-bootstrap.heroku.com).

Clone to a folder, then:  
&nbsp;&nbsp;Create a file in the root of the folder named: .env  
&nbsp;&nbsp;copy and paste the following with any changes you want:  

```
  DATABASE_USER=user
  DATABASE_PASSWORD=password
  DEV_DATABASE_NAME=starter_bootstrap_dev
  TEST_DATABASE_NAME=starter_bootstrap_test
  DATABASE_NAME=starter_bootstrap
  GMAIL_USERNAME=user@gmail.com
  GMAIL_PASSWORD=password
  HOST_PROTOCOL=http://
  HOST_DOMAIN=localhost:3000
```
Then run:

```
bundle
rake db:migrate
```

Run:
```
rspec
```
to run all tests.

Then just add your own Models, Views, and Controllers!

Filters:  
&nbsp;&nbsp;before_action :require_signin  
&nbsp;&nbsp;before_action :require_correct_user_or_admin  
&nbsp;&nbsp;before_action :require_admin  

Helpers:  
&nbsp;&nbsp;current_user - Gets currently logged in user  
&nbsp;&nbsp;current_user? - Is a user logged in  
&nbsp;&nbsp;current_user_admin? - is current_user an admin  


Password reset is sent using Gmail.  To use Mandrill, Mailgun, etc. just
edit the config/environments/development.rb and production.rb changing the
settings in config.action_mailer.smtp_settings.
