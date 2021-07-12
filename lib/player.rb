# frozen_string_literal: true

class Player
  attr_accessor :mark
  
  def initialize(mark)
    @mark = mark
  end

  def input
    loop do
      puts "Please, select a column number, from 1 to 7."
      user_input = gets.chomp.to_i
      return user_input - 1 if user_input.between?(1, 7)
    end
  end
  
end