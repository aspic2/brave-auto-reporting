require './resources/confidential.rb'

class TestData

  def initialize()
    @campaign_hash = Confidential::TEST_CAMPAIGN_HASH

  end

  attr_accessor :campaign_hash


end
