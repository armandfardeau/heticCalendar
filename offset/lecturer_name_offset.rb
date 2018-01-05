class Lecturer_name_offset
  attr_accessor :param

  def initialize(param)
    @param = param
  end

  def column
    'G'
  end

  def row
    case @param
      when 1, 2
        5
      when 3, 4
        6
      when 5, 6
        7
      when 7, 8
        8
      when 9, 10
        9
      else
        # type code here
    end
  end
end