require './test_data.rb'

class Campaign

  def initialize(campaign_hash)
    @campaign_name = campaign_hash.fetch(:campaign_name)
    @campaign_id = campaign_hash.fetch(:campaign_id)
    @sheets_url = campaign_hash.fetch(:sheets_url)
  end

  attr_reader :campaign_name, :campaign_id, :sheets_url
end

if __FILE__ == $0
  data = TestData.new()
  campaign = Campaign.new(data.campaign_hash)
end
