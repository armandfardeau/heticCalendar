require_relative 'coord_finder'
require 'date'

class Lecture
  attr_accessor :room, :course_title, :start_time, :end_time, :duration, :professor, :group

  def initialize(excel, lecture_number)
    @excel = excel
    @lecture_number = lecture_number
    @course_title = set_course_title
    @professor = set_professor
    @room = set_room
    @start_time = set_start_time
    @end_time = set_end_time
    @duration = set_duration
    @group = set_group
  end

  def set_professor
    professor = Coord_finder.new(@lecture_number, 'professor')
    professor_arr = @excel.cell(professor.column, professor.row).lines.map(&:chomp)

    return professor_arr[0] if professor_arr[1].nil?

    if @lecture_number.odd?
      professor_arr[0]
    else
      professor_arr[1]
    end
  end


  def set_course_title
    course = Coord_finder.new(@lecture_number, 'course_title')
    course_arr = @excel.cell(course.column, course.row).lines.map(&:chomp)

    return course_arr[0] if course_arr[1].nil?

    if @lecture_number.odd?
      course_arr[0]
    else
      course_arr[1]
    end
  end

  def set_room
    room = Coord_finder.new(@lecture_number, 'room')
    room_arr = @excel.cell(room.column, room.row).lines.map(&:chomp)

    return room_arr[0] if room_arr[1].nil?
    if room_arr.size <= 2
      if @lecture_number.odd?
        room_arr[0]
      else
        room_arr[1]
      end
    else
      room_arr.delete_at(0)
      if @lecture_number.odd?
        room_arr[0]
      else
        room_arr[1]
      end
    end
  end

  def set_start_time
    day = Coord_finder.new(@lecture_number, 'day')
    day = @excel.cell(day.column, day.row).to_int

    month = Coord_finder.new(@lecture_number, 'month')
    month = @excel.cell(month.column, month.row)
    month = month_to_decimal month

    year = Coord_finder.new(@lecture_number, 'year')
    year = @excel.cell(year.column, year.row).to_int

    hour = hour_finder @lecture_number, 'start'

    DateTime.new year, month, day, hour, 0, 0, 0, +1 # year, month, day, hour, min, sec, offset, zone
  end

  def set_end_time
    day = Coord_finder.new(@lecture_number, 'day')
    day = @excel.cell(day.column, day.row).to_int

    month = Coord_finder.new(@lecture_number, 'month')
    month = @excel.cell(month.column, month.row)
    month = month_to_decimal month

    year = Coord_finder.new(@lecture_number, 'year')
    year = @excel.cell(year.column, year.row).to_int

    hour = hour_finder @lecture_number, 'end'

    DateTime.new year, month, day, hour, 0, 0, 0, +1 # year, month, day, hour, min, sec, offset, zone
  end

  def set_duration
    @end_time.hour - @start_time.hour
  end


  def set_group
    group_par_pos = @course_title =~ /\(/
    return 3 if group_par_pos.nil?
    group_index = @course_title[(group_par_pos + 1) .. -2]
    group = ''
    if group_index.size <= 5
      if @lecture_number.odd?
        group = group_index[1]
      elsif @lecture_number.even?
        group = group_index[4]
      end
    else
      if @lecture_number.odd?
        group = group_index[2..3]
      elsif @lecture_number.even?
        group = group_index[5..6]
      end
    end
    group.to_i
  end

  def month_to_decimal(month)
    case month
      when 'jan'
        1
      when 'fèv'
        2
      when 'mar'
        3
      when 'avr'
        4
      when 'mai'
        5
      when 'jui'
        6
      when 'jui'
        7
      when 'aou'
        8
      when 'sep'
        9
      when 'oct'
        10
      when 'nov'
        11
      when 'déc'
        12
      else
        raise 'unknown month'
    end
  end

  def hour_finder(lecture_number, request)
    if request == 'start'
      case lecture_number
        when 1, 5, 9, 13, 17
          9
        when 2, 6, 10, 14, 18
          11
        when 3, 7, 11, 15, 19
          14
        when 4, 8, 12, 16, 20
          16
        else
          raise 'unknown hour'
      end
    elsif request == 'end'
      case lecture_number
        when 1, 5, 9, 13, 17
          11
        when 2, 6, 10, 14, 18
          13
        when 3, 7, 11, 15, 19
          16
        when 4, 8, 12, 16, 20
          18
        else
          raise 'unknown hour'
      end
    else
      raise 'Not a valid request, valid request are: start, end'
    end
  end

end
