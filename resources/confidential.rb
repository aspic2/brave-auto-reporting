# Use this file to store things like access tokens, passwords, and
# campaign IDs that should not be shared in the remote repository.

module Confidential
  BRAVE_ACCESS_TOKEN = ""
  BRAVE_USERNAME = ""
  BRAVE_PASSWORD = ""
  BRAVE_API_URL = ""

  GOOGLE_REPORTS_LIST_ID = ""
  GOOGLE_REPORTS_LIST_RANGE = ""

  TEST_CAMPAIGN_HASH = {"campaign_name": "",
    "campaign_id": "",
    "sheets_url": "",
    "tab_name": ""
  }

  BRAVE_HASH = {"access_token": Confidential::BRAVE_ACCESS_TOKEN,
                "username": Confidential::BRAVE_USERNAME,
                "password": Confidential::BRAVE_PASSWORD,
                "url": Confidential::BRAVE_API_URL
                }

  GOOGLE_HASH = {"sheet_id": Confidential::GOOGLE_REPORTS_LIST_ID,
  "sheet_range": Confidential::GOOGLE_REPORTS_LIST_RANGE
  }

end
