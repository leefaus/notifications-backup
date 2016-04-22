## README

This is a set of **Ruby/Rails** example applications GitHub uses during their _1 day_ partner enablement.  These applications are **WIP**, so leverage at your own risk.

To get started:
- Install Ruby > 2.2.4
- `gem install bundler`
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
- Once the application is created, save the `client_id` AND `client_secret` to be used later in the `application.yml`
- `bundle install`
- `bundle exec figaro install`
- Create the following key/value pairs corresponding to your install in the `config/application.yml`
  - `github_client_id: <value>`
  - `github_application_secret: <value>`
  - `github_enterprise_url: <value>`
  - `heroku_application: <value>`
- `figaro heroku:create`
- `git commit -a -m "figaro environment variables"`
- `git push --force heroku oauth-example:master`
- `heroku run rails db:migrate`
- Open a browser and point to `https://<HEROKU_URL>/`
- Click the `Sign In via GitHub` button in the right hand corner
  - You should be redirected to either GitHub.com or GitHub Enterprise
  - Authorize the application 
  - Click the `Sign Out` button
  - **Done...**

### API Example

**Setup and Deploying**

- Create a [**Personal Access Token**](https://help.github.com/articles/creating-an-access-token-for-command-line-use/)
- `git checkout api-example`
- `bundle install`
- `bundle exec figaro install`
- Create the following key/value pairs corresponding to your install in the `config/application.yml`
  - `github_client_id: <value>`
  - `github_application_secret: <value>`
  - `github_enterprise_url: <value>`
  - `github_oauth_personal_token: <value>`
  - `heroku_application: <value>`
- `figaro heroku:create`
- `git commit -a -m "figaro environment variables"`
- `git push --force api-example:master`
- Open a browser to `https://<HEROKU_URL>/status`
- _Login to GitHub if required_
- Create a commit and pull request in GitHub
  - Copy the SHA from GitHub and paste it into the status field in your Heroku application
  - Click the `Create` button
