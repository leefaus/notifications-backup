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
      @client.create_status("republic/calculator", @sha,
              'failure', {:context => "Enablement Status",
              :target_url => "http://#{ENV['heroku_application']}/status",
              :description => "Enablement Failure!"})
    rescue
      puts "Unable to create status against #{@sha} with client_id::#{ENV['github_client_id']} and application_secret::#{ENV['github_application_secret']}"
    end
  end

  def index
    @client = self.connect
    repository = "republic/calculator"
    branch = "master"
    @commit_builder = Array.new
    commits = @client.commits(repository, branch )
    # puts "COMMITS #{commits.inspect}"
    commits.each do |c|
      status_builder = Hash.new
      status_builder[:sha] = c.sha
      status_builder[:author] = c.commit.author.name
      status_builder[:committer] = c.commit.committer.name
      status_builder[:message] = c.commit.message
      status_builder[:statuses] = @client.statuses(repository, c.sha)
      @commit_builder.push(status_builder)
      #puts "STATUS BUILDER #{@status_builder.inspect}"
    end
  end

  def connect
    Octokit.configure do |c|
      c.api_endpoint = "http://#{ENV['github_enterprise_url']}/api/v3/"
      # allow self signed cert https
      c.connection_options[:ssl] = { :verify => false }
    end
    client = Octokit::Client.new(
        :access_token => ENV['github_oauth_personal_token']
      )
  end
end
