# Use this file to store things like access tokens, passwords, and
# campaign IDs that should not be shared in the remote repository.

module Confidential
  brave_access_token = ""
  brave_username = ""
  brave_password = ""
  brave_api_url = ""

  google_reports_list_id = ""
  google_reports_list_range = ""

  test_campaign_hash = {"campaign_name": "",
    "campaign_id": "",
    "sheets_url": "",
    "tab_name": ""
  }

  brave_hash = {"access_token": Confidential.brave_access_token,
                "username": Confidential.brave_username,
                "password": Confidential.brave_password,
                "url": Confidential.brave_api_url
                }

  google_confidential_hash = {"reports_list_sheet_id": Confidential.google_reports_list_id,
  "reports_list_range": Confidential.google_reports_list_range
  }
  
end
