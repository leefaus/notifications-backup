## README

This is a set of **Ruby/Rails** example applications GitHub uses during their _1 day_ partner enablement.  These applications are **WIP**, so leverage at your own risk.

To get started:

- Create a Heroku account
- Install the [Heroku Toolbelt CLI](https://toolbelt.heroku.com/)

**From a Terminal**  
- `heroku login`
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

- `git checkout oauth-example`
- Login to GitHub.com or GitHub Enterprise
- [Create a new Oauth Application](https://help.github.com/enterprise/admin/guides/user-management/using-github-oauth/)
  - The **Homepage URL** should be your **HEROKU_URL**
  - The **Authorization Callback URL** should be `https://<HEROKU_URL>/users/auth/github/callback`
- Once the application is created, copy the `CLIENT_ID` AND `CLIENT_SECRET`
  - Edit `config/initializers/devise.rb`
  - Replace the `CLIENT_ID`
  - Replace the `CLEINT_SECRET`
    - With GitHub Enterprise, put your GitHub Enterprise Server URL in the corresponding locations
    - With GitHub.com, remove the `client_options` section
- `git commit -a -m "modify URLs"`
- `git push --force heroku oauth-example:master`
- `heroku run rails db:migrate`
- Open a browser and point to `https://<HEROKU_URL>/users/sign_in`
- Click the `Sign In with GitHub` link
  - You should be redirected to either GitHub.com or GitHub Enterprise
  - Authorize the application 
  - **Done...**

