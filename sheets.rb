require './quickstart.rb'
require './credentials.rb'
require './campaigns'
require './test_data'

class SheetsApi
  # TODO: make this class read from the spreadsheet of live Brave campaigns and store the data in memory

  def initialize(service, spreadsheet_id, range)
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
      rows.push({"campaign_name": row[0], "campaign_id": row[1], "sheets_url": row[2]})
    end
    return rows
  end

  def clear_sheet_values()
    # Untested. Never ran this
    response = @service.clear_values(@spreadsheet_id, @range)
    return response
  end

end


if __FILE__ == $0
  service = GoogleService.new().service
  google_creds = GoogleCredentials.new()
  api = SheetsApi.new(service, google_creds.reports_list_sheet_id, google_creds.reports_list_range)
  campaign_data = api.read_sheet_values()

  # This is not technically necessary to test this class / module
  campaigns_list = Array.new()
  campaign_data.each { |d|
    campaigns_list.push(Campaign.new(d))
  }
  campaigns_list.each{|c|
    puts c.campaign_name
  }
end
