require "sinatra"
require "sinatra/reloader"
require "http"
require "json"
require "dotenv/load"

EXCHANGE_KEY = ENV.fetch("STOCK_KEY")

def fetch_currencies 
  list_url = "https://api.exchangerate.host/list?access_key=" + "#{EXCHANGE_KEY}"
  response = HTTP.get(list_url).to_s
  parsed_response = JSON.parse(response)
  currencies_hash = parsed_response['currencies']
  currencies_list = currencies_hash.keys
end



get("/") do
  @currencies = fetch_currencies
  erb(:home)
end

get("/:source_currency") do
  # returns list of conversions
  @currencies = fetch_currencies
  @source = params.fetch("source_currency")
  erb(:flexible)

end

get("/:source_currency/:target_currency") do
  # returns 1 source equals x target
  @currencies = fetch_currencies
  @source = params.fetch("source_currency")
  @target = params.fetch("target_currency")
  
  conversion_url = "https://api.exchangerate.host/convert?from=" + "#{@source}" + "&to=" + "#{@target}" +"&amount=1&access_key=" + "#{EXCHANGE_KEY}"
  parsed_response = JSON.parse(HTTP.get(conversion_url).to_s)
  @conversion = parsed_response["result"]


  erb(:convert)

end 


=begin 
displays pairs of currencies and 
the current exchange rate between them, 
based on API data.
=end
