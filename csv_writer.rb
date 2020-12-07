require 'date'

class CSVWriter
  def initialize(filename, data)
    @filepath = Dir.pwd + "/reports/" + DateTime.now.strftime("%Y-%m-%d") + "_" + filename + ".csv"
    @data = data
  end

  def write()
    target = open(@filepath, 'w')
    @data.each_line { |line|
    target.write(line)
    }
    target.close()
  end
end
