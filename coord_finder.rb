class Coord_finder
  def initialize(lecture_number, data_requested)
    @lecture_number = lecture_number
    @data_requested = data_requested
  end

  def column
    case @data_requested
      when 'room'
        set_room_column
      when 'course_title'
        set_course_column
      when 'professor'
        set_professor_column
      when 'day'
        'B'
      when 'month'
        'C'
      when 'year'
        'D'
      else
        raise 'You must request the following : room, course_title, professor, day, month, year'
    end
  end

  def row
    case @lecture_number
      when 1..4
        5
      when 4..8
        6
      when 8..12
        7
      when 12..16
        8
      when 16..20
        9
      else
        raise 'no column found'
    end
  end


  def set_room_column
    case @lecture_number
      when 1, 2, 5, 6, 9, 10, 13, 14, 17, 18
        'H'
      when 3, 4, 7, 8, 11, 12, 15, 16, 19, 20
        'O'
      else
        raise 'no column found'
    end
  end

  def set_course_column
    case @lecture_number
      when 1, 2, 5, 6, 9, 10, 13, 14, 17, 18
        'F'
      when 3, 4, 7, 8, 11, 12, 15, 16, 19, 20
        'M'
      else
        raise 'no column found'
    end
  end

  def set_professor_column
    case @lecture_number
      when 1, 2, 5, 6, 9, 10, 13, 14, 17, 18
        'G'
      when 3, 4, 7, 8, 11, 12, 15, 16, 19, 20
        'N'
      else
        raise 'no column found'
    end
  end
end