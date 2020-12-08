# Fill in these values with your info and save a local copy
class BraveCredentials

  def initialize()
    @access_token = "Your_access_token"

    # To generate an access token:
    @username = "your_username"
    @password = "your_password"
    @report_url = "your_base_url_for_reports"
  end

  attr_reader :access_token, :report_url
end

class GoogleCredentials
  def initialize()
    @reports_list_sheet_id = "your_google_sheet_id_for_your_list_of_reports"
    @reports_list_range = "Reports List!A2:D"
  end

  attr_reader :reports_list_sheet_id, :reports_list_range, :write_to_range_without_tab_name
end
