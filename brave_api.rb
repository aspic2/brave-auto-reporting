require './credentials.rb'
require './campaigns.rb'

require 'uri'
require 'open-uri'

brave_credentials = BraveCredentials.new()
campaign = Campaign.new()


class BraveReportsApi

  def initialize(credentials)
    @credentials = credentials
    @headers = {
        "authorization": "Bearer #{credentials.access_token}",
        # "content-type" as a string
        'contenttype': 'application/json',
    }
    @url = nil
    @report = nil
  end

  attr_accessor :url, :report

  def build_url(campaign_id)
    @url = URI.join("https://ads-serve.brave.com/v1/report/campaign/csv/", campaign_id)
    return self
  end

  def retrieve_report()
    @report = URI.open(@url, "authorization" => @headers.fetch(:authorization), "content-type" => @headers.fetch(:contenttype))
  end

  def print_report()
    @report.each_line {|line|
      puts line
    }
  end

end


if __FILE__ == $0
  api = BraveReportsApi.new(brave_credentials).build_url(campaign.campaign_id)
  api.retrieve_report()
end
