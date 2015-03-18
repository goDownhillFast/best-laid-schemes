class Event

  def initialize(session)
    @client_id = session[:calendar_id]
    @client = Google::APIClient.new
    @client.authorization.access_token = session[:auth_token]
    @calendar = @client.discovered_api('calendar', 'v3')
  end

  def where(opts)
    camelized = camelize_keys(opts)
    list_events(camelized)
  end

  private

  def camelize_keys(opts={})
    new_opts = {}
    opts.each do |key, value|
      string_key = key.to_s
      camelized_key = string_key.camelize(:lower)
      new_opts[camelized_key] = value
    end
    new_opts
  end

  def list_events(opts={})
    opts[:singleEvents] = true
    opts[:calendarId] = @calendar_id
    calendar_data = @client.execute(api_method: @calendar.events.list,
                    parameters: opts)

    @data = parse_google_data(calendar_data.body)
  end

  def parse_google_data(data)
    ActiveSupport::JSON.decode(data)['items']

    data.map do |event|
      g_activity_id = event['summary'].slice!(0,4).to_i
      next unless g_activity_id > 0 && event['status'] != "cancelled"
      event_start = Time.parse(event['start']['dateTime'])
      event_end = Time.parse(event['end']['dateTime'])

      {   start: event_start,
          end: event_end,
          name: event['summary'],
          old_activity_id: g_activity_id,
          google_event_id: event['id'],
          time: (event_end - event_start)/3600
      }
    end
  end

  def new_event(opts={})
    @client.execute(api_method: @calendar.events.insert,
                    parameters: {calendarId: opts[:calendar_id]},
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