require './auto-reporting/brave_api.rb'
require './auto-reporting/credentials.rb'
require './auto-reporting/csv_writer.rb'
require './auto-reporting/quickstart.rb'
require './auto-reporting/sheets.rb'
require './auto-reporting/test_data.rb'
require './auto-reporting/report_data.rb'

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
    report = brave_api.set_report()
    return report
  end

  def process_report(report)
    report_data = ReportData.new(report)
    return report_data.process_data()
  end

  def update_spreadsheet(campaign, report_text)
    write_api = SheetsApi.new(@google_service, campaign.sheets_id, campaign.get_write_range())
    write_api.clear_values_and_write_new_ones(report_text)
  end


  def run()
    build_campaigns()
    count = 0
    @campaigns.each {|campaign|
      begin
        count += 1
        print "#{count} "
        raw_report = get_report(campaign)
        report_text = process_report(raw_report)
        update_spreadsheet(campaign, report_text)
        # Fixes Google Sheets API RateLimitError.
        sleep(15)

      rescue OpenURI::HTTPError => oe
        puts "\n\nOpenURI Error\n#{oe.inspect} updating data for #{campaign.campaign_name}.\n"
        puts "Check the Brave api key, then the report ID, either of which can cause this error.\n"
        puts "Backtrace:"
        oe.backtrace_locations.each do |location|
          puts location
        end
        puts "\nSkipping...\n\n"
        next
      rescue Google::Apis::ClientError => ge
        puts "\n\nGoogle Error updating data for #{campaign.campaign_name}."
        puts "\n#{ge.inspect}\n"
        puts "\nSkipping...\n\n"
        next
      rescue => e
        puts "\n\nError #{e.inspect} updating data for #{campaign.campaign_name}."
        puts "Backtrace:"
        e.backtrace_locations.each do |location|
          puts location
        end
        puts "\nSkipping...\n\n"
        next
      end
    }

    puts "\n\nFinished"
  end


end



if __FILE__ == $0
  ar = AutoReporting.new()
  ar.run()
end
