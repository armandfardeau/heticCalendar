require_relative 'coord_finder'

class Lecture
  attr_accessor :room, :course_title, :start_time, :end_time, :duration, :professor, :group

  def initialize(excel, lecture_number)
    @excel = excel
    @lecture_number = lecture_number
    @course_title = set_course_title
    @professor = set_professor
    @room = set_room
    @start_time = 0
    @end_time = 0
    @duration = 0
    @group = 0
  end

  def set_professor
    professor = Coord_finder.new(@lecture_number, 'professor')
    @excel.cell(professor.column, professor.row)
  end


  def set_course_title
    course = Coord_finder.new(@lecture_number, 'course_title')
    @excel.cell(course.column, course.row)
  end

  def set_room
    room = Coord_finder.new(@lecture_number, 'room')
    @excel.cell(room.column, room.row)
  end
end