# brave-auto-reporting
Ruby program that pulls campaign reports from Brave's dashboard and updates our reporting spreadsheets

## REQUIREMENTS
  - gem install google-api-client

  - Login for Brave's ad platform
  - Write access to all of the Google Spreadsheets you plan to use
  - Activated Google Spreadsheets API
  - a credentials.json file

## GETTING STARTED

You can run this program from bash with run-auto-reporting.  
(The script redirects to this projects base directory, so no need to worry about where you run the script from.)  

Or you can run it directly from auto_reporting.rb  

### Before You Begin  

  1. Update resources/confidential.rb to use your credentials and test data
  2. Activate the Google Spreadsheets API and place credentials.json in the base directory of the project.
  3. make sure run-auto-reporting points to the correct version of Ruby
