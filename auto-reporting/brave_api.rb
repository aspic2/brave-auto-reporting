require './auto-reporting/credentials.rb'
require './auto-reporting/campaigns.rb'
require './auto-reporting/csv_writer.rb'
require './auto-reporting/test_data.rb'
require './auto-reporting/report_data.rb'

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
    @report_as_array = Array.new()
  end

  attr_accessor :url, :report

  def build_url()
    @url = URI.join(@credentials.report_url, @campaign_id)
    return self
  end

  def set_report()
    build_url()
    @report = URI.open(@url, "authorization" => @headers.fetch(:authorization), "content-type" => @headers.fetch(:contenttype))
    return @report
  end

  def get_report_text_as_UTF_8()
    # OBSELETE. USE SIMILAR METHOD IN ReportData CLASS
    set_report()
    report_text = @report.read
    utf_8_report_text = report_text.force_encoding('UTF-8')
    return utf_8_report_text
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
  report = api.set_report()
  report_data = ReportData.new(report)
  CSVWriter.new("test_report", report_data.data).write()
end
