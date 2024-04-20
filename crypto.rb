require 'httparty'
require 'json'

def fetch_crypto_data
  url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd'
  response = HTTParty.get(url)
  
  if response.code == 200
    JSON.parse(response.body)
  else
    puts "Error fetching cryptocurrency data: #{response.message}"
    nil
  end
end

def analyze_crypto_data(data)
  return unless data
  
  sorted_data = data.sort_by { |crypto| crypto['market_cap'] }.reverse
  
  top_5_cryptos = sorted_data.take(5).map do |crypto|
    {
      name: crypto['name'],
      price: crypto['current_price'],
      market_cap: crypto['market_cap']
    }
  end
  
  top_5_cryptos
end

def display_crypto_data(cryptos)
  puts "Top 5 Cryptocurrencies by Market Capitalization:"
  cryptos.each do |crypto|
    puts "Name: #{crypto[:name]}"
    puts "Price: $#{crypto[:price]}"
    puts "Market Cap: $#{crypto[:market_cap]}"
    puts "-----------------------------"
  end
end

crypto_data = fetch_crypto_data

if crypto_data
  top_5_cryptos = analyze_crypto_data(crypto_data)
  display_crypto_data(top_5_cryptos)
end
