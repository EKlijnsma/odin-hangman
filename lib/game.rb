# frozen_string_literal: true

require_relative 'dictionary'
require 'json'
require_relative 'secret_word'
require_relative 'methods'

# Game class for the game of Hangman
# Maximum of 7 incorrect guesses. Words are loaded form the google 10,000 words text file
class Game
  def initialize
    load_dictionary
    # allow max 7 incorrect guesses
    @incorrect_guesses_left = 7
    @guesses = ''
    @round = 1
  end

  def load_dictionary
    contents = File.read('google-10000-english-no-swears.txt').split("\n")
    @words = Dictionary.new(contents)
    @secret = SecretWord.new(@words.random)
  end

  def play
    until @incorrect_guesses_left.zero?
      display(@round)
      # ask for new input
      char = get_guess
      @guesses += char
      @incorrect_guesses_left -= 1 if @secret.add_guess(char) == false
      # update display
      puts "Word to guess: #{@secret}"
      # check for win / lose
      @secret.win? ? break : continue_game?

      @round += 1
    end
    # Show final message
    @secret.win? ? 'Congratulations, you won!' : "You lost! The secret word was '#{@secret.secret.join}'"
    Methods.terminate
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

  def continue_game?
    print "Press 'N' for a new round, 'S' to Save the game, or 'Q' to quit without saving: "
    input = gets.chomp.downcase
    # Ensure the input is valid
    until %w[n q s].include?(input)
      print "Invalid input\nPress 'N' for a new round, 'S' to Save the game and quit, or 'Q' to quit without saving: "
      input = gets.chomp.downcase
    end
    case input
    when 'q'
      Methods.terminate
    when 's'
      save_game
    else
      true
    end
  end

  def to_json(*_args)
    JSON.dump({
                incorrect_guesses_left: @incorrect_guesses_left,
                guesses: @guesses,
                secret: @secret.to_json,
                round: @round
              })
  end

  def self.from_json(string)
    data = JSON.parse(string)
    instance = allocate
    instance.instance_variable_set(:@guesses, data['guesses'])
    instance.instance_variable_set(:@round, data['round'])
    instance.instance_variable_set(:@incorrect_guesses_left, data['incorrect_guesses_left'])
    instance.instance_variable_set(:@secret, SecretWord.from_json(data['secret']))
    instance
  end

  def save_game
    # Write the JSON string to a file
    File.write('saved_game.json', to_json)
    puts 'Game saved'
    Methods.terminate
  end

  attr_accessor :secret, :round, :incorrect_guesses_left, :guesses
end
