class Board
  def initialize
    @data = Array.new(3) { Array.new(3, nil) }
    @winner = nil
    @over = false
  end

  def [](y, x)
    @data[y][x]
  end

  def []=(y, x, v)
    if v.nil? or (v.respond_to? :to_sym and [:x, :o].include? v.to_sym)
      @data[y][x] = v.to_sym
    else
      raise ArgumentError, 'Value must be :x, :o, or nil'
    end
  end

  def winner
    return @winner unless @winner.nil?

    catch(:win) do
      # Check rows
      @data.each do |row|
        if row.all? { |e| not e.nil? and e == row.first }
          @winner = row.first
          @over = true
          throw :win
        end
      end

      # Check columns
      @data.transpose.each do |col|
        if col.all? { |e| not e.nil? and e == col.first }
          @winner = col.first
          @over = true
          throw :win
        end
      end

      # Check diagonals
      diag1 = [@data[0][0], @data[1][1], @data[2][2]]
      diag2 = [@data[0][2], @data[1][1], @data[2][0]]
      diags = [diag1, diag2]
      diags.each do |diag|
        if diag.all? { |e| not e.nil? and e == diag.first }
          @winner = diag.first
          @over = true
          throw :win
        end
      end
    end

    # Tie game
    if @data.flatten.none? { |e| e.nil? }
      @winner = false
      @over = true
    end

    return @winner
  end

  # Return a list of possible moves as (y, x) pairs
  def possible_moves
    moves = []

    @data.each_with_index do |row, y|
      row.each_with_index do |e, x|
        moves << [y, x] if e.nil?
      end
    end

    moves
  end

  def over?
    winner()
    @over
  end

  def dup
    b = Board.new
    3.times do |y|
      3.times do |x|
        b[y, x] = @data[y][x] unless @data[y][x].nil?
      end
    end
    b
  end

  def to_s
    @data.map do |row|
      ' ' +  row.map { |e| if e.nil? then ' ' else e.to_s end }.join(' | ')
    end.join("\n---+---+---\n")
  end
end
