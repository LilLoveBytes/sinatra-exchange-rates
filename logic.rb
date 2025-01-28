require "http"
require "json"
require "dotenv/load"

exchange_key = ENV.fetch("STOCK_KEY")

# api call to get list of currencies
list_url = "https://api.exchangerate.host/list?access_key=" + "#{exchange_key}"

parsed_response = JSON.parse(HTTP.get(list_url))

currencies = parsed_response['currencies']
currencies_list = currencies.keys

cov_url= "https://api.exchangerate.host/convert?from=USD&to=INR&amount=1&access_key=#{exchange_key}"

parsed_cov = JSON.parse(HTTP.get(cov_url))
pp parsed_cov["result"]
