require './resources/confidential.rb'

class BraveCredentials

  def initialize()
    credentials_hash = Confidential::BRAVE_HASH
    @access_token = credentials_hash[:access_token]

    # To generate an access token:
    @username = credentials_hash[:username]
    @password = credentials_hash[:password]
    @report_url = credentials_hash[:url]
  end

  attr_reader :access_token, :report_url
end

class GoogleCredentials
  def initialize()
    credentials_hash = Confidential::GOOGLE_HASH
    @reports_list_sheet_id = credentials_hash[:sheet_id]
    @reports_list_range = credentials_hash[:sheet_range]
  end

  attr_reader :reports_list_sheet_id, :reports_list_range
end
