# frozen_string_literal: true

require_relative 'dictionary'
require_relative 'secret_word'

# Game class for the game of Hangman
# Maximum of 7 incorrect guesses. Words are loaded form the google 10,000 words text file
class Game
  def initialize
    load_dictionary
    # allow max 7 incorrect guesses
    @incorrect_guesses_left = 7
    @guesses = ''
  end

  def load_dictionary
    contents = File.read('google-10000-english-no-swears.txt').split("\n")
    @words = Dictionary.new(contents)
  end

  def play
    @secret = SecretWord.new(@words.random)
    round = 1
    display(round)
    until @incorrect_guesses_left == 0
      round += 1
      # ask for a guess
      char = get_guess
      @guesses += char
      @incorrect_guesses_left -= 1 if @secret.add_guess(char) == false
      # update display
      display(round)
      # check for win / lose
      @secret.win? ? break : next
    end
    # Show final message
    @secret.win? ? 'Congratulations, you won!' : "You lost! The secret word was '#{@secret.secret.join}'"
  end

  def display(round)
    # display message showing the round, the word incl. any guessed letters
    # a string of all letters that have been guessed, and the number of mistakes left
    puts "\n--- ROUND #{round} ---\nWord to guess: #{@secret}\nCharacters guessed: #{@guesses}\n#{@incorrect_guesses_left} incorrect guesses remaining"
  end

  def get_guess
    print 'Guess a letter: '
    input = gets.chomp.downcase
    # Ensure the input is 1 character from a-z
    until input.length == 1 && input.between?('a', 'z')
      print "Invalid input, enter exactly 1 letter from a to z.\nGuess a letter: "
      input = gets.chomp.downcase
    end
    input
  end
end
