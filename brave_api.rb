require './credentials.rb'
require './campaigns.rb'
require './csv_writer.rb'
require './test_data.rb'

require 'uri'
require 'open-uri'




class BraveReportsApi

  def initialize(campaign_id, creds)
    @credentials = creds
    @headers = {
        "authorization": "Bearer #{creds.access_token}",
        # "content-type" as a string
        'contenttype': 'application/json',
    }
    @campaign_id = campaign_id
    @url = nil
    @report = nil
  end

  attr_accessor :url, :report

  def build_url()
    @url = URI.join(@credentials.report_url, @campaign_id)
    return self
  end

  def retrieve_report()
    build_url()
    @report = URI.open(@url, "authorization" => @headers.fetch(:authorization), "content-type" => @headers.fetch(:contenttype))
  end

  def print_report()
    @report.each_line {|line|
      puts line
    }
  end

end


if __FILE__ == $0
  brave_credentials = BraveCredentials.new()
  test_data = TestData.new()
  campaign = Campaign.new(test_data.campaign_hash)
  api = BraveReportsApi.new(campaign.campaign_id, brave_credentials)
  api.retrieve_report()
  CSVWriter.new("test_report", api.report).write()
end
