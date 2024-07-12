# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/methods'

input = Methods.start

case input
when 'q'
  Methods.terminate
when 'l'
  # Read the JSON string from the file
  json_string = File.read('saved_game.json')

  # Deserialize the JSON string to a SecretWord instance
  hangman = Game.from_json(json_string)
  puts 'Saved game has been loaded'
else
  hangman = Game.new
  puts 'New game has been loaded'
end

puts hangman.play
