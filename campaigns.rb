require './test_data.rb'

class Campaign

  def initialize(campaign_hash)
    @campaign_name = campaign_hash.fetch(:campaign_name)
    @campaign_id = campaign_hash.fetch(:campaign_id)
    @sheets_url = campaign_hash.fetch(:sheets_url)
    @tab_name = campaign_hash.fetch(:tab_name)
    @sheets_id = get_sheets_id()
  end

  attr_reader :campaign_name, :campaign_id, :sheets_url, :tab_name
  attr_accessor :sheets_id

  def get_sheets_id()
    spreadsheets_regex = /\/spreadsheets\/d\/([a-zA-Z0-9\-_]+)/
    id_plus_leader = spreadsheets_regex.match(@sheets_url)
    # Spreadsheet ID is stored in match object at hash 1
    sheets_id = id_plus_leader[1]
    return sheets_id
  end

  def get_write_range()
    # default range to use when writing into a spreadsheet
    return @tab_name + "!" + "A1:M"
  end

end



if __FILE__ == $0
  data = TestData.new()
  campaign = Campaign.new(data.campaign_hash)
  puts "Sheets ID = #{campaign.sheets_id}"
end
