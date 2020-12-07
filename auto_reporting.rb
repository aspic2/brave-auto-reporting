require './brave_api.rb'
require './credentials.rb'
require './csv_writer.rb'
require './quickstart.rb'
require './sheets.rb'
require './test_data.rb'

class AutoReporting

  def initialize()
    @campaigns = nil
    @google_service = GoogleService.new().service
    @brave_credentials = nil
    @google_credentials = GoogleCredentials.new()
  end

  def run()
    # 1. Read spreadsheet with campaign info. Build and save as list of @campaigns.

    #TODO: Can you not hardcode this?
    master_list_api = SheetsApi.new(service, google_credentials.reports_list_sheet_id, google_credentials.reports_list_range)



    #2. Retrieve Brave data for each campaign

    #3 Update Campaign's reporting spreadsheet
  end



end



if __FILE__ == $0
  ar = AutoReporting.new()
  ar.run()
end
