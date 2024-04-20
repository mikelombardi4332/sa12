require 'httparty'
require 'json'

def fetch_events(api_key, location)
  url = "https://www.eventbriteapi.com/v3/events/search/?location.address=#{location}&token=#{api_key}"
  response = HTTParty.get(url)
  
  if response.code == 200
    JSON.parse(response.body)['events']
  else
    puts "Error fetching events: #{response.message}"
    nil
  end
end

def display_events(events)
  puts "Upcoming Events:"
  events.each do |event|
    name = event['name']['text']
    venue = event['venue']['name']
    start_time = event['start']['local']
    
    puts "Name: #{name}"
    puts "Venue: #{venue}"
    puts "Start Time: #{start_time}"
    puts "-----------------------------"
  end
end

api_key = 'ORTT5453QIJX5H2N7XZC'
location = 'San Francisco' 

events = fetch_events(api_key, location)

if events
  display_events(events)
end
