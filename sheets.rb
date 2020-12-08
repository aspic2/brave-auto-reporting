require './brave_api.rb'
require './quickstart.rb'
require './credentials.rb'
require './campaigns'
require './test_data'

require 'csv'
require "google/apis/sheets_v4"


class SheetsApi
  # TODO: make this class read from the spreadsheet of live Brave campaigns and store the data in memory

  def initialize(service, spreadsheet_id, range=nil)
    @service = service
    @spreadsheet_id = spreadsheet_id
    @range = range
  end

  attr_reader :spreadsheet_id, :range

  def read_sheet_values()
    rows = Array.new()
    response = @service.get_spreadsheet_values(@spreadsheet_id, @range)
    puts "No data found." if response.values.empty?
    response.values.each do |row|
      rows.push({"campaign_name": row[0],
                 "campaign_id": row[1],
                 "sheets_url": row[2],
                 "tab_name": row[3]
                 }
               )
    end
    return rows
  end

  def clear_values_and_write_new_ones(data)
    clear_sheet_values()
    response = write_sheet_values(data)
    return self
  end

  def clear_sheet_values()
    puts "Clearing Spreadsheet ID = #{@spreadsheet_id}, Range = #{@range}"
    response = @service.clear_values(@spreadsheet_id, @range)
    return response
  end

  def write_sheet_values(data)
    data_as_array = CSV.new(data).read
    value_range = Google::Apis::SheetsV4::ValueRange.new(range: @range, values: data_as_array)
    puts "Writing to Spreadsheet ID = #{@spreadsheet_id}, Range = #{@range}"
    response = @service.update_spreadsheet_value(@spreadsheet_id, @range, value_range, value_input_option: "USER_ENTERED")
    return response
  end


end


if __FILE__ == $0
  service = GoogleService.new().service
  google_creds = GoogleCredentials.new()
  # Test Reading Sheets
  read_api = SheetsApi.new(service, google_creds.reports_list_sheet_id, google_creds.reports_list_range)
  campaign_data = read_api.read_sheet_values()

  # This is not technically necessary to test this class / module
  campaigns_list = Array.new()
  campaign_data.each { |d|
    campaigns_list.push(Campaign.new(d))
  }
  campaigns_list.each{|c|
    puts c.campaign_name
  }

  # Test Writing to Sheets
  write_to_campaign = Campaign.new(TestData.new().campaign_hash)
  write_api = SheetsApi.new(service, write_to_campaign.sheets_id, write_to_campaign.get_write_range())
  write_api.clear_sheet_values()

  brave_report = BraveReportsApi.new(write_to_campaign.campaign_id, BraveCredentials.new()).retrieve_report()
  brave_report_text = brave_report.read
  puts "encoding before = #{brave_report_text.encoding}"
  # hopefully fixes json encoding error for Coinspot
  brave_report_text.force_encoding('UTF-8')
  puts "encoding after = #{brave_report_text.encoding}"
  puts write_api.write_sheet_values(brave_report_text)

  write_api.clear_values_and_write_new_ones(brave_report_text)

end
