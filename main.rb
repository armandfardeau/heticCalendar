# encoding: UTF-8
#!/usr/bin/env ruby

require_relative 'transform'
require_relative 'lecture'
require 'icalendar'

excel = Transform.new(ARGV[0]).read
@cal = Icalendar::Calendar.new
(1..10).each do |i|
  input = Lecture.new(excel, i)

  event = Icalendar::Event.new
  event.dtstart = Icalendar::Values::DateTime.new(input.start_time)
  event.dtend = Icalendar::Values::DateTime.new(input.end_time)
  event.summary = input.lecture_name
  event.description = input.lecturer_name
  event.ip_class = "PRIVATE"
  @cal.add_event(event)
end

f = File.open('HeticCalendar.ics', 'w') {|file| file.write(@cal.to_ical)}
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