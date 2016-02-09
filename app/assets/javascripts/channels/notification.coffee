App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    new Notification data["event"]
    @appendLine(data)

  appendLine: (data) ->
    html = @createLine(data)
    $("#event").append(html)

  createLine: (data) ->
    """
    <div class="event-line">
      <span class="event-data">#{data["event"]}</span>
    </div>
    """

  notify: ->
    @perform 'notify'
