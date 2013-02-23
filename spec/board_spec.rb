require File.expand_path '../helper', __FILE__

require 'board'

describe Board do
  before :all do
    @pieces = [:x, :o]
  end

  describe '#over?' do
    it 'declares game is not over when board is empty' do
      b = Board.new
      b.over?.should be_false
    end

    it 'declares game is not over when board is partially filled' do
      b = Board.new
      b[0,0] = :x ; b[0,1] = :o ; b[0,2] = :x
      b.over?.should be_false

      b = Board.new
      b[0,1] = :x ; b[1,1] = :o ; b[2,1] = :x
      b.over?.should be_false

      b = Board.new
      b[0,0] = :x ; b[1,1] = :o ; b[2,2] = :x
      b.over?.should be_false
    end

    it 'declares game is over with horizontal three in a row' do
      @pieces.each do |piece|
        3.times do |i|
          b = Board.new
          3.times { |j| b[i, j] = piece }
          b.over?.should be_true
        end
      end
    end

    it 'declares game is over with vertical three in a row' do
      @pieces.each do |piece|
        3.times do |j|
          b = Board.new
          3.times { |i| b[i, j] = piece }
          b.over?.should be_true
        end
      end
    end

    it 'declares game is over with main diagonal three in a row' do
      @pieces.each do |piece|
        b = Board.new
        3.times { |i| b[i, i] = piece }
        b.over?.should be_true
      end
    end

    it 'declares game is over with minor diagonal three in a row' do
      @pieces.each do |piece|
        b = Board.new
        3.times { |i| b[i, 2-i] = piece }
        b.over?.should be_true
      end
    end

    it 'declares game is over for cat\'s game' do
      b = Board.new
      b[0,0] = :x ; b[0,1] = :o ; b[0,2] = :x
      b[1,0] = :x ; b[1,1] = :o ; b[1,2] = :o
      b[2,0] = :o ; b[2,1] = :x ; b[2,2] = :x
      b.over?.should be_true
    end
  end

  describe '#winner' do
    it 'returns nil when game is not over' do
      b = Board.new
      b.winner.should be_nil

      b[0,0] = :x ; b[0,1] = :o ; b[0,2] = :x
      b.winner.should be_nil

      b[1,0] = :o ; b[1,1] = :o ; b[1,2] = :x
      b.winner.should be_nil

      b[2,0] = :o ; b[2,1] = :x
      b.winner.should be_nil
    end

    it 'returns false for cat\'s game' do
      b = Board.new
      b[0,0] = :x ; b[0,1] = :o ; b[0,2] = :x
      b[1,0] = :x ; b[1,1] = :o ; b[1,2] = :o
      b[2,0] = :o ; b[2,1] = :x ; b[2,2] = :x
      b.winner.should be_false
    end

    it 'declares the correct winner for horizontal wins' do
      @pieces.each do |piece|
        3.times do |i|
          b = Board.new
          3.times { |j| b[i, j] = piece }
          b.winner.should eq(piece)
        end
      end
    end

    it 'declares the correct winner for vertical wins' do
      @pieces.each do |piece|
        3.times do |j|
          b = Board.new
          3.times { |i| b[i, j] = piece }
          b.winner.should eq(piece)
        end
      end
    end

    it 'declares the correct winner for main diagonal wins' do
      @pieces.each do |piece|
        b = Board.new
        3.times { |i| b[i, i] = piece }
        b.winner.should eq(piece)
      end
    end

    it 'declares the correct winner for minor diagonal wins' do
      @pieces.each do |piece|
        b = Board.new
        3.times { |i| b[i, 2-i] = piece }
        b.winner.should eq(piece)
      end
    end

    it 'declares the correct winner when the board is full' do
      b = Board.new
      b[0,0] = :x ; b[0,1] = :o ; b[0,2] = :x
      b[1,0] = :o ; b[1,1] = :o ; b[1,2] = :x
      b[2,0] = :o ; b[2,1] = :x ; b[2,2] = :x
      b.winner.should eq(:x)
    end
  end

end
