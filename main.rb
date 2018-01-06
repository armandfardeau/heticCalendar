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

def lecture_to_ical(lecture, cal)
  event = Icalendar::Event.new
  event.dtstart = Icalendar::Values::DateTime.new(lecture.start_time)
  event.dtend = Icalendar::Values::DateTime.new(lecture.end_time)
  event.summary = lecture.course_title
  event.description = "Professor: #{lecture.professor}\nGroup : G#{lecture.group}\nRoom: #{lecture.room}\nDuration: #{lecture.duration} h"
  event.ip_class = "PRIVATE"
  cal.add_event(event)
end

@cal = Icalendar::Calendar.new

# 1.upto(20) do |i|
#   print_lecture lecture unless lecture.group == 2
# end


(1..20).each do |i|
  lecture = Lecture.new(excel, i)
  lecture_to_ical(lecture, @cal) unless lecture.group == 2
end

f = File.open('HeticCalendarG1.ics', 'w') {|file| file.write(@cal.to_ical)}
begin
  puts 'Success!'
rescue
  $stderr.print "IO failed: " + $!
  f.close
  File.delete(opName)
  raise
ensure
  puts 'Execution is finished'
end