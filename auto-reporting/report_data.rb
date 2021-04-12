require './auto-reporting/credentials.rb'
require './auto-reporting/campaigns.rb'
require './auto-reporting/csv_writer.rb'
require './auto-reporting/test_data.rb'
require './auto-reporting/brave_api.rb'

require 'csv'

class ReportData

  def initialize(data)
    @data = data
    @csv = nil
    @unwanted_columns = [:campaign_id, :creative_set_id]
  end

  def convert_data_to_csv()
    @csv = CSV.table(@data, headers: true)
    return @csv
  end

  def check_headers()
    csv_table = @csv
    puts csv_table.headers()
  end

  def delete_columns(array_of_column_headers)
    array_of_column_headers.each { |header|
      @csv.delete(header)
    }
  end

  def get_report_text_as_UTF_8(text)
    # fixes character error
    # ERROR = multi_json-1.15.0/lib/multi_json/adapters/json_common.rb:19:in `encode': "\xE2" from ASCII-8BIT to UTF-8 (Encoding::UndefinedConversionError)
    report_text_as_utf_8 = text.force_encoding('UTF-8')
    return report_text_as_utf_8
  end

  def process_data()
    convert_data_to_csv()
    delete_columns(@unwanted_columns)
    csv_string = @csv.to_csv()
    return get_report_text_as_UTF_8(csv_string)

  end


  attr_accessor :data, :csv, :unwanted_columns

end


if __FILE__ == $0
  brave_credentials = BraveCredentials.new()
  test_data = TestData.new()
  campaign = Campaign.new(test_data.campaign_hash)
  api = BraveReportsApi.new(campaign.campaign_id, brave_credentials)
  report_data = ReportData.new(api.set_report())
  utf_text = report_data.process_data()
end
