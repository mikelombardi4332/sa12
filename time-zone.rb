require 'httparty'
require 'json'

def fetch_time_for_timezone(area, location)
  url = "http://worldtimeapi.org/api/timezone/#{area}/#{location}"
  response = HTTParty.get(url)
  
  if response.code == 200
    JSON.parse(response.body)
  else
    puts "Error fetching time data: #{response.message}"
    nil
  end
end

def display_time_data(data, area, location)
  return unless data
  
  current_time = data['datetime']
  
  puts "The current time in #{area}/#{location} is #{current_time}"
end

area = 'Europe'
location = 'London' 

time_data = fetch_time_for_timezone(area, location)

if time_data
  display_time_data(time_data, area, location)
end
