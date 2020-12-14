require './auto-reporting/brave_api.rb'
require './auto-reporting/credentials.rb'
require './auto-reporting/csv_writer.rb'
require './auto-reporting/quickstart.rb'
require './auto-reporting/sheets.rb'
require './auto-reporting/test_data.rb'

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
    puts "There are #{@campaigns.length} campaigns in the list today."
  end

  def get_report(campaign)
    brave_api = BraveReportsApi.new(campaign.campaign_id, @brave_credentials)
    report = brave_api.get_report_text_as_UTF_8()
    return report
  end

  def update_spreadsheet(campaign, report_text)
    write_api = SheetsApi.new(@google_service, campaign.sheets_id, campaign.get_write_range())
    write_api.clear_values_and_write_new_ones(report_text)
    puts "Updated\n\n\n"
  end


  def run()
    build_campaigns()
    @campaigns.each {|campaign|
      begin
        report_text = get_report(campaign)
        # Fixes Google Sheets API RateLimitError. Can shorten this timespan if necessary
        sleep(15)
        update_spreadsheet(campaign, report_text)
      rescue
        puts "Something went wrong updating data for #{campaign.campaign_name}. Skipping...\n\n"
        next
      end
    }
    puts "Finished"
  end


end



if __FILE__ == $0
  ar = AutoReporting.new()
  ar.run()
end
