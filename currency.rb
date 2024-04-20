require 'httparty'
require 'json'

def fetch_exchange_rate(api_key, source_currency, target_currency)
  url = "https://v6.exchangeratesapi.io/latest?base=#{source_currency}&symbols=#{target_currency}&apikey=#{api_key}"
  response = HTTParty.get(url)
  
  if response.code == 200
    data = JSON.parse(response.body)
    data['rates'][target_currency]
  else
    puts "Error fetching exchange rate: #{response.message}"
    nil
  end
end

def convert_currency(amount, exchange_rate)
  (amount * exchange_rate).round(2)
end

def display_conversion_result(source_currency, target_currency, amount, converted_amount)
  puts "#{amount} #{source_currency} is equal to #{converted_amount} #{target_currency}"
end

api_key = 'f67ab89eb3453e267115f566'
source_currency = 'USD' # Replace with the source currency
target_currency = 'EUR' # Replace with the target currency
amount = 100 # Amount to convert

exchange_rate = fetch_exchange_rate(api_key, source_currency, target_currency)

if exchange_rate
  converted_amount = convert_currency(amount, exchange_rate)
  display_conversion_result(source_currency, target_currency, amount, converted_amount)
end
