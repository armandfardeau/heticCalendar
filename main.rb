# encoding: UTF-8
#!/usr/bin/env ruby

require_relative 'transform'
require 'icalendar'
require_relative 'Lecture'

excel = Transform.new(ARGV[0]).read

def print_lecture(lecture)
  puts lecture.course_title
  puts lecture.professor
  puts lecture.room
  puts lecture.start_time
  puts lecture.end_time
  puts lecture.duration
  puts lecture.group
end

1.upto(20) do |i|
  print_lecture Lecture.new(excel, i)
end