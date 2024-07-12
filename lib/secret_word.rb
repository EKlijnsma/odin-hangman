# frozen_string_literal: true

# This class contains the secret word for hangman in the @secret attribute
# It also contains a @display attribute that shows the word in underscores
# For every letter that is guessed correctly the letter will be filled in to the @display attribute
class SecretWord
  def initialize(word)
    @secret = word.chars
    @display = Array.new(@secret.length, '_') # start with an empty @display
  end

  def to_s
    # show word with correct letters, e.g. _ r o g r a _ _ i n g
    @display.join(' ')
  end

  def add_guess(char)
    if @secret.include?(char)
      update(char)
      true
    else
      false
    end
  end

  def update(char)
    # Update the display attribute
    @secret.each_with_index { |_, i| @display[i] = char if @secret[i] == char }
  end

  def win?
    @secret == @display
  end

  attr_reader :secret, :display
end
