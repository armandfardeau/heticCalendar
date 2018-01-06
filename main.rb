# encoding: UTF-8
#!/usr/bin/env ruby

require_relative 'transform'
require 'icalendar'
require_relative 'Lecture'

excel = Transform.new(ARGV[0]).read

def print_lecture(lecture)
  puts "Course title: #{lecture.course_title}"
  puts "Professor: #{lecture.professor}"
  puts "Room: #{lecture.room}"
  puts "Start time: #{lecture.start_time}"
  puts "End time: #{lecture.end_time}"
  puts "Duration: #{lecture.duration} h"
  puts "Group : G#{lecture.group}"
  puts
end

1.upto(20) do |i|
  print_lecture Lecture.new(excel, i)
end