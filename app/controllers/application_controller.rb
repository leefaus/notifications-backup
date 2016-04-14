class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def connect
    Octokit.configure do |c|
      c.api_endpoint = "https://#{ENV['github_enterprise_url']}/api/v3/"
      # allow self signed cert https
      c.connection_options[:ssl] = { :verify => false }
    end
    client = Octokit::Client.new(
      :client_id     => ENV["github_client_id"],
      :client_secret => ENV["github_application_secret"]
      )
  end
end
