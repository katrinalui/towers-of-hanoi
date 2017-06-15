# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp.html) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bash
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.

class TowersOfHanoi
  attr_reader :towers

  def initialize
    @towers = [[3, 2, 1], [], []]
  end

  def render
    top = render_row(2)
    mid = render_row(1)
    bottom = render_row(0)
    "#{top.join(' ')}\n#{mid.join(' ')}\n#{bottom.join(' ')}\n"\
    "___ ___ ___\n 1   2   3 "
  end

  def render_row(index)
    towers.map do |tower|
      if tower[index].nil?
        '   '
      else
        disc = '*' * tower[index]
        disc + ' ' * (3 - disc.length)
      end
    end
  end

  def play
    until won?
      puts render
      get_move
    end
    game_won
  end

  def get_move
    print "Enter a move (ex. from to): "
    input = gets.chomp
    from_tower, to_tower = input.split.map { |move| move.to_i - 1 }

    if valid_move?(from_tower, to_tower)
      move(from_tower, to_tower)
    else
      puts "Invalid move! Please try again."
    end
  end

  def move(from_tower, to_tower)
    disc = towers[from_tower].pop
    towers[to_tower] << disc
  end

  def valid_move?(from_tower, to_tower)
    from = towers[from_tower]
    to = towers[to_tower]
    return false if from.empty?
    return false if !to.empty? && from.last > to.last
    true
  end

  def won?
    towers[1].length == 3 || towers[2].length == 3
  end

  def game_won
    puts "Congratulations! You win!"
    puts render
  end
end
