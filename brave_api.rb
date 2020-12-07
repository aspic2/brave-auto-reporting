require './credentials.rb'
require './campaigns.rb'

require 'open-uri'

brave_credentials = BraveCredentials.new()
campaign = Campaign.new()

headers = {
    "authorization": "Bearer #{brave_credentials.access_token}",
    # "content-type" as a string
    'contenttype': 'application/json',
}

puts headers

url = "https://ads-serve.brave.com/v1/report/campaign/csv/#{campaign.campaign_id}"

report = URI.open(url, "authorization" => headers.fetch(:authorization), "content-type" => headers.fetch(:contenttype))

report.each_line {|line|
  puts line
}
