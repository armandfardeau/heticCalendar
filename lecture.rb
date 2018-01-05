require_relative 'date_translator'
require_relative 'offset/year_offset'
require_relative 'offset/month_offset'
require_relative 'offset/day_offset'
require_relative 'offset/lecture_name_offset'
require_relative 'offset/lecturer_name_offset'
require 'date'

class Lecture

  attr_accessor :lecture_name, :start_time, :end_time, :duration, :lecturer_name

  def initialize(excel, param)
    year = excel.cell(YearOffset.new(param).column, YearOffset.new(param).row).to_int
    month = Date_translator.new(excel.cell(MonthOffset.new(param).column, MonthOffset.new(param).row)).month
    day = excel.cell(Day_offset.new(param).column, Day_offset.new(param).row).to_int
    hour = 9
    min = 0
    sec = 0
    offset = 0
    zone = 1

    @lecture_name = excel.cell(Lecture_name_offset.new(param).column, Lecture_name_offset.new(param).row)
    @lecturer_name = excel.cell(Lecturer_name_offset.new(param).column, Lecturer_name_offset.new(param).row)
    @start_time = DateTime.new(year, month, day, hour, min, sec, offset, zone)
    @end_time = DateTime.new(year, month, day, hour + 2, min, sec, offset, zone)
    @duration = @end_time.hour - @start_time.hour
  end

  def get_array
    lecture = Array.new
    lecture.push(@lecture_name)
    lecture.push(@lecturer_name)
    lecture.push(@start_time)
    lecture.push(@end_time)
    lecture.push(@duration)
    lecture
  end
end