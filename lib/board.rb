# frozen_string_literal: true
require_relative "../lib/player"

class Board
  attr_accessor :cells

  def initialize
    @cells = Array.new(6) { Array.new(7, "__") }
    @player_black = Player.new("⚫")
    @player_white = Player.new("⚪")
  end

  def play_game
    puts "Welcome message"
    play_turns
  end

  def play_turns
    until full?
      player_input(@player_black)
      return puts("Player Black WON") if game_over?

      player_input(@player_white)
      return puts("Player White Won") if game_over?
    end
    puts "It's a draw!"
  end

  def player_input(player_name, column = nil)
    loop do
      column = player_name.input
      break if valid_column?(column)

      puts "Full column, please choose another one."
    end
    mark_cell!(column, player_name)
    @cells.each { |row| print "#{row.join(" | ")}\n"}
  end

  def mark_cell!(column, player_name)
    @cells.reverse_each do |row| 
      next unless row[column] == "__"

      row[column] = player_name.mark
      break
    end
  end

  def valid_column?(column)
    @cells.first[column] == "__"
  end

  def horizontal?
    rows = @cells.map(&:join)
    return true if rows.any? { |row| row =~ /⚫{4}|⚪{4}/ }
  end

  def vertical?
    columns = @cells.transpose.map(&:join)
    return true if columns.any? { |column| column =~ /⚫{4}|⚪{4}/ }
  end

  def downward_diagonal?
    padding = [*0..(@cells.length - 1)].map { |i| [nil] * i }
    downward_diagonal = padding.reverse.zip(@cells).zip(padding).map(&:flatten).transpose.map(&:join)
    return true if downward_diagonal.any? { |column| column =~ /⚫{4}|⚪{4}/ }
  end

  def upward_diagonal?
    padding = [*0..(@cells.length - 1)].map { |i| [nil] * i }
    upward_diagonal = padding.zip(@cells).zip(padding.reverse).map(&:flatten).transpose.map(&:join)
    return true if upward_diagonal.any? { |column| column =~ /⚫{4}|⚪{4}/ }
  end

  def full?
    @cells.first.none?("__")
  end

  def game_over?
    horizontal? || vertical? || downward_diagonal? || upward_diagonal?
  end
end