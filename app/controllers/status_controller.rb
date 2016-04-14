class StatusController < ApplicationController

  def index
  end

  def create
    @sha = params[:sha]
    @client = super.connect
    @client.create_status("development/notifications", @sha,
            'failure', {:context => "Enablement Status",
            :target_url => "https://#{ENV['heroku_application']}/status",
            :description => "Enablement Fail!"})
  end
end
