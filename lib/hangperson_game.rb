class HangpersonGame
  
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :valid
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
  
  def guess(letter)
    raise ArgumentError if letter.nil? || letter=~/[^a-zA-Z]/ || letter.empty? 
    
    letter = letter.downcase
    if  @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return false
    else
      if
        @word.include? letter
        @guesses.concat(letter)
      else
        @wrong_guesses.concat(letter)
      end
    end
  end
  
  def word_with_guesses
    if guesses.empty?
      "-"*@word.size
    else
      @word.gsub(/[^#{@guesses}]/, "-")
    end
  end

  def check_win_or_lose
    if
      @word == self.word_with_guesses
      return :win
    elsif
      @wrong_guesses.length == 7
      return :lose
    else
      return :play
    end
  end
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
