require 'rubygems'
require 'roo'
require 'csv'

class Transform

  def initialize(input)
    @input = input
  end

  def die_with_usage(msg=nil)
    puts msg if msg
    exit
  end

  def read
    filename = @input
    die_with_usage 'You must pass a file.' unless filename

    if filename =~ /xlsx$/
      excel = Roo::Excelx.new(filename, {:expand_merged_ranges => true})
    else
      excel = Roo::Excel.new(filename, {:expand_merged_ranges => true})
    end
    excel
  end
end