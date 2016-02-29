class StatusController < ApplicationController

  def index
  end

  def create
    @sha = params[:sha]
    @client = self.connect
    @client.create_status("development/notifications", @sha,
            'failure', {:context => "Enablement Status",
            :target_url => "https://glacial-taiga-57884.herokuapp.com/status",
            :description => "Enablement Fail!"})
  end

  def connect
    Octokit.configure do |c|
      c.api_endpoint = "https://ec2-54-194-237-229.eu-west-1.compute.amazonaws.com/api/v3/"
      # allow self signed cert https
      c.connection_options[:ssl] = { :verify => false }
    end
    client = Octokit::Client.new(:login => 'chewbacca', :password => 'P@ssw0rd')
  end
end
