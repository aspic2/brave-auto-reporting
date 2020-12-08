require './brave_api.rb'
require './credentials.rb'
require './csv_writer.rb'
require './quickstart.rb'
require './sheets.rb'
require './test_data.rb'

class AutoReporting

  def initialize()
    @campaigns = Array.new()
    @google_service = GoogleService.new().service
    @brave_credentials = BraveCredentials.new()
    @google_credentials = GoogleCredentials.new()
  end

  def build_campaigns()
    master_list_api = SheetsApi.new(@google_service, @google_credentials.reports_list_sheet_id, @google_credentials.reports_list_range)

    campaign_data = master_list_api.read_sheet_values()

    campaign_data.each { |d|
      @campaigns.push(Campaign.new(d))
    }
  end

  def run()
    # 1. Read spreadsheet with campaign info. Build and save as list of @campaigns.
    build_campaigns()

    #2. Retrieve Brave data for each campaign
    @campaigns.each {|campaign|
      brave_api = BraveReportsApi.new(campaign.campaign_id, @brave_credentials)
      report = brave_api.retrieve_report()
      report_text = report.read
      # fixes issue with Coinspot campaign
      # ERROR = multi_json-1.15.0/lib/multi_json/adapters/json_common.rb:19:in `encode': "\xE2" from ASCII-8BIT to UTF-8 (Encoding::UndefinedConversionError)
      report_text.force_encoding('UTF-8')
      puts "Report Encoding = #{report_text.encoding}"

      #3 Update Campaign's reporting spreadsheet
      write_api = SheetsApi.new(@google_service, campaign.sheets_id, campaign.get_write_range())
      write_api.clear_values_and_write_new_ones(report_text)
      puts "Updated\n\n\n"
    }

    puts "Finished"
  end

end



if __FILE__ == $0
  ar = AutoReporting.new()
  ar.run()
end
