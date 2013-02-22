#!/usr/bin/env ruby
# simple_ai.rb
# Simple minimax tic-tac-toe AI

$:.unshift File.dirname(__FILE__)

require 'board'

class SimpleAI
  def initialize(board, player)
    @board = board
    @player = player.to_sym

    case @player
    when :x
      @other_player = :o
    when :o
      @other_player = :x
    else
      raise ArgumentError, 'Player must be :x or :o'
    end

    @min_memo = {}
    @max_memo = {}
  end

  def make_move
    return false if @board.over?

    moves = @board.possible_moves

    best = -1
    best_move = moves.first

    moves.each do |move|
      b = @board.dup
      b[*move] = @player

      v = min_value(b)

      if v > best
        best = v
        best_move = move
      end
    end

    @board[*best_move] = @player

    true
  end

  private

  def min_value(board)
    return utility(board) if board.over?

    unless @min_memo.include? board
      moves = board.possible_moves

      values = moves.map do |move|
        b = board.dup
        b[*move] = @other_player

        max_value(b)
      end

      @min_memo[board] = values.min
    end

    @min_memo[board]
  end

  def max_value(board)
    return utility(board) if board.over?

    unless @max_memo.include? board
      moves = board.possible_moves

      values = moves.map do |move|
        b = board.dup
        b[*move] = @player

        min_value(b)
      end

      @max_memo[board] = values.max
    end

    @max_memo[board]
  end

  def utility(board)
    case board.winner
    when @player
      1
    when @other_player
      -1
    else
      0
    end
  end
end
