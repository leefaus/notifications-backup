class StatusController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    @sha = params[:sha]
    puts @sha.inspect
    @client = self.connect
    puts @client.inspect
    begin
      @client.create_status("development/notifications", @sha,
              'failure', {:context => "Enablement Status",
              :target_url => "https://#{ENV['heroku_application']}/status",
              :description => "Enablement Failure!"})
    rescue
      puts "Unable to create status against #{@sha} with client_id::#{ENV['github_client_id']} and application_secret::#{ENV['github_application_secret']}"
    end
  end

  def connect
    Octokit.configure do |c|
      c.api_endpoint = "https://#{ENV['github_enterprise_url']}/api/v3/"
      # allow self signed cert https
      c.connection_options[:ssl] = { :verify => false }
    end
    client = Octokit::Client.new(
        :access_token => ENV['github_oauth_personal_token']
      )
  end
end
