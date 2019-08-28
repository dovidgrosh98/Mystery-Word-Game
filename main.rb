class Word
  # Stores the provided word in an instance variable and
  # setups up any other instance variables.
  attr_accessor :word, :guessed_word, :lives
  def initialize(word)
    @word = word
    @guessed_word = ['_'] * word.length
    @lives = 3
  end

  # Guess a letter in the word.
  # Should return a boolean. true if the letter is in the word, false if not.
  def guess?(letter)
    @word.downcase.include?(letter)
  end

  # Whether all letters in the word have been guessed correctly.
  def guessed_all_correct?
    @word == guessed_word.join('')
  end

  # Display the current state of the guessed word for the player.
  def output_word
    puts @guessed_word.join(' ')
    puts @lives
  end

  # Check whether a provided character is a letter
  def self.is_letter?(character)
    character.downcase.include?("abcdefghijklmnopqrstuvwxyz")
  end
end

class MysteryWordGame
  # Initialize any state in the game, and start the game loop.
  def initialize
    @game = ''
    @word_array = []
  end

  def ask_for_word
    puts "Input a Word"
    word = gets.chomp
    @game = Word.new word
    @word_array = word.split('')
  end

  # Run the game loop, which continues until the player wins or loses.
  def game_loop
    ask_for_word
    while !@game.guessed_all_correct?
      puts "enter guess"
      guess = gets.chomp
      if !@game.guess? guess then
        puts "incorrect"
        @game.lives -= 1
        @game.output_word
        return puts "You Lost" if @game.lives == 0
      elsif @game.guess? guess 
        puts "correct"
        @word_array.each_with_index do |val, index|
          @game.guessed_word[index] = guess if val == guess
        end
        @game.output_word
        puts "You Win" if @game.guessed_all_correct?
      end
    end
  end
end

new_game = MysteryWordGame.new 
new_game.game_loop