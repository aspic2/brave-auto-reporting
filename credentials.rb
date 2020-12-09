# Fill in these values with your info and save a local copy
class BraveCredentials

  def initialize()
    @access_token = "Your_access_token"

    # To generate an access token:
    @username = "your_username"
    @password = "your_password"
    @report_url = "insert_url_for_brave_reporting"
  end

  attr_reader :access_token, :report_url
end

class GoogleCredentials
  def initialize()
    @reports_list_sheet_id = "sheets_id_for_your_list_of_campaigns"
    @reports_list_range = "Insert_Your_Tab_Name_and_Range!A1:Z"
  end

  attr_reader :reports_list_sheet_id, :reports_list_range
end
