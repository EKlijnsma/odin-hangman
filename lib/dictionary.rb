# frozen_string_literal: true

# This class defines a dictionary that is initialized by taking all words of 5-12 letters from an array
# It contains a method to obtain a random word
class Dictionary
  def initialize(array)
    # store all words between 5 and 12 characters long in the dictionary
    @words = array.select { |word| word.length.between?(5, 12) }
  end

  def random
    # return a random word from the dictionary
    @words.sample
  end
end
