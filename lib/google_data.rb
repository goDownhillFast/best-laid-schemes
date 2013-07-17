class GoogleData

  def initialize(token)
    @client = Google::APIClient.new
    @client.authorization.access_token = token
    @calendar = @client.discovered_api('calendar', 'v3')
  end

  def list_events(calendar_id='primary', opts={})
    @client.execute(:api_method => @calendar.events.list,
                    :parameters => {calendarId: calendar_id,
                    timeMin: opts[:start_time],
                    timeMax: opts[:end_time]})
  end

  def calendar_list
    @client.execute(
        :api_method => @calendar.calendar_list.list,
        :parameters => {},
        :headers => {'Content-Type' => 'application/json'})
  end

  def new_event(calendar_id="primary", opts={})
    @client.execute(api_method: @calendar.events.insert,
                    parameters: {calendarId: calendar_id},
                    body: JSON.dump({summary: opts[:title],
                                     location: opts[:location],
                                     start: {
                                         dateTime: opts[:start_time]
                                     },
                                     end: {
                                         dateTime: opts[:end_time]
                                     }
                                    }),
                    headers: {'Content-Type' => 'application/json'})

  end
end