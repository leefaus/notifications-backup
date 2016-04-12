## README

This is a set of **Ruby/Rails** example applications GitHub uses during their _1 day_ partner enablement.  These applications are **WIP**, so leverage at your own risk.

To get started:

- Install the [Heroku Toolbelt CLI](https://toolbelt.heroku.com/)
- `git clone https://github.com/leefaus/notifications`

### Webhook Example

**Setup and Deploying**

- `cd notifications`
- `git checkout webhook-example`
- `bundle install`
- `heroku create`
- Copy the URL from the above command and paste the URL into `config/environments/production.rb`
  - `config.action_cable_url`
  - `config.action_cable.allowed_request_origins`
- `git commit -a -m "update websocket URLs"`
- `heroku plugins:install heroku-redis`
- `heroku addons:create heroku-redis:hobby-dev`
- `git push heroku webhook-example:master`

1. Wait for the application to start by running.  
2. Once running, open your browser to `https://<HEROKU_URL>/webhook`
3. Trigger a Webhook in GitHub to send the notification to the URL **2**

### Oauth Example

**Setup and Deploying**

