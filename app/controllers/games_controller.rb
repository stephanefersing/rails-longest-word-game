require "open-uri"
class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('A'..'Z').to_a.sample }
  end

  def score
  @letters = params[:letters].split
  @word = params[:word].upcase
  @word = @word.split('')
  if @word.nil? == true
    @conclusion = "it's so null"
  else
    if (confirm(@word) == true && exist(@word) == true)
      @conclusion = "Congratulations! #{@word.join.to_s} is a valid English word!"
    elsif exist(@word) == false
      @conclusion = "sorry but #{@word.join.to_s} does not seem to be a valid English word!"
    elsif confirm(@word) == false
      @conclusion = "sorry but it's not in the grid!"
    end
  end
  return @conclusion
  end

  def confirm(word)
    count = 0
    word.all? do |wd|
      @letters.include?(wd) ? count += 1 : count += 0
    end
    if (count = @letters.length && word.length <= @letters.length)
      return true
    end
  end

  def exist(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word.join}")
    json = JSON.parse(response.read)
    return json["found"]
  end
end
