class Date_translator
  def initialize(param)
    @param = param
  end

  def month
    case @param
      when 'Jan'
        1
      when 'Fèv'
        2
      when 'Mar'
        3
      when 'Avr'
        4
      when 'Mai'
        5
      when 'Juin'
        6
      when 'Juil'
        7
      when 'Aout'
        8
      when 'Sept'
        9
      when 'Oct'
        10
      when 'Nov'
        11
      when 'déc'
        12
      else
        # type code here
    end
  end
end