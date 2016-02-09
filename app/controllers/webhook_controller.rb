class WebhookController < ApplicationController
   skip_before_action :verify_authenticity_token

  def listener
    body_as_string = request.body.read
    hook_event = request.headers['X-Github-Event']
    puts hook_event
    # body = JSON.parse(body_as_string)
    # ActionCable.server.broadcast 'notifications', message: render_message(hook_event)
    ActionCable.server.broadcast 'notifications', {event: "#{hook_event}"}

    response_body = response.body
  end

  def index
  end

end
