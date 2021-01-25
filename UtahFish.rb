# require 'open-uri'
# require 'net/http'

# url = "https://dwrapps.utah.gov/fishstocking/Fish"
# uri = URI.parse(url)
# response = Net::HTTP.get_response(uri)
# puts response.body


# require "HTTParty"

# html = HTTParty.get("https://dwrapps.utah.gov/fishstocking/Fish")
# puts html

require 'open-uri'
require 'nokogiri'
require 'csv'

html = open("https://dwrapps.utah.gov/fishstocking/Fish")
doc = Nokogiri::HTML(html)

tbody = doc.css('tbody').text.split("\t\t\t\r")
puts tbody

stocking_info =[]
stocking_info.push([tbody])
CSV.open('stockdata.csv', "w") do |csv|
  csv << stocking_info
end

data_arr = []
stock_date = doc.css("td").find {|td| td.attributes['class'].value.include?("stockdate")}.text
quantity = doc.css("td").find {|td| td.attributes['class'].value.include?("quantity")}.text
water_name = doc.css("td").find {|td| td.attributes['class'].value.include?("watername")}.text

data_arr.push([water_name,stock_date,quantity])

CSV.open('data.csv', "w") do |csv|
  csv << data_arr
end


