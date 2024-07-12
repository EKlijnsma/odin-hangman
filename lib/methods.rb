# frozen_string_literal: true

# This module stores a couple methods I want to use in main.rb
# And also I have not used modules before so I want to experiment a bit
module Methods
  def self.start
    print "Hangman starting\nPress 'N' for a New Game, 'L' to Load the saved game, or 'Q' to quit: "
    input = gets.chomp.downcase

    # Ensure the input is valid
    until %w[n q l].include?(input)
      print "Invalid input\nPress 'N' for a New Game, 'L' to Load the saved game, or 'Q' to quit: "
      input = gets.chomp.downcase
    end
    input
  end

  def self.terminate
    puts 'Exiting the program, goodbye!'
    exit
  end
end
