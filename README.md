# brave-auto-reporting
Ruby program that pulls campaign reports from Brave's dashboard and updates our reporting spreadsheets

## requirements
gem install google-api-client

Login for Brave's ad platform
Write access to all of the Google Spreadsheets you plan to use
Activated Google Spreadsheets API
a credentials.json file

## GETTING STARTED
1. Update credentials.rb to use your credentials
2. Update test_data.rb to hold test data, or delete references to it thoughout the campaign.
3. Activate the Google Spreadsheets API and place credentials.json in the base directory of the project.
4. make sure run-auto-reporting points to the correct version of Ruby
