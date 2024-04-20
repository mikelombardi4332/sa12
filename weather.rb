require 'httparty'
require 'json'

def fetch_weather_data(api_key, city)
  url = "https://api.openweathermap.org/data/2.5/forecast?q=#{city}&appid=#{api_key}&units=metric"
  response = HTTParty.get(url)
  
  if response.code == 200
    JSON.parse(response.body)
  else
    puts "Error fetching weather data: #{response.message}"
    nil
  end
end

def calculate_average_temperature(data)
  temperatures = data['list'].map { |forecast| forecast['main']['temp'] }
  average_temperature = temperatures.sum / temperatures.size
  
  average_temperature.round(2)
end

def display_weather_data(city, average_temperature)
  puts "Weather data for #{city}:"
  puts "Average Temperature: #{average_temperature}°C"
end

api_key = 'f8a87a9703d1aedd43be0297123e187d'
city = 'London' 

weather_data = fetch_weather_data(api_key, city)

if weather_data
  average_temperature = calculate_average_temperature(weather_data)
  display_weather_data(city, average_temperature)
end
