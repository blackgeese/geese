module Geese

  # Represents a Game of Geese board, you can create a new board with a
  # number of squares. A classical Game of Geese board has 63 squares,
  # exluding the 'start' square.
  #
  # Players can be added using `add_player`. This will add the players
  # automatically to the 'start' squard
  class Board

    attr_reader :number_of_squares, :players

    # Creates a new Board with the specified `number_of_squares`, this
    # does not include the 'start' square, which is always present.
    #
    # The default `number_of_squares` is 63, for a classica Game of Geese.
    def self.create_with_number_of_squares(number_of_squares = 63)
      self.new(number_of_squares)
    end

    def double_roll_at?(square)
      @double_roll_squares.include?(square)
    end

    def double_roll_at(square)
      @double_roll_squares << square unless double_roll_at?(square)
    end

    def geesified_square_at?(square)
      @geesified_squares.include?(square)
    end

    def geesify_square_at(square)
      @geesified_squares << square unless geesified_square_at?(square)
    end

    # Adds a player to the board, the following attributes need to be
    # present:
    #
    #  * name:  "Gandalf"    # Name of the player
    #  *  age:   342          # Age of the player in years
    #  *  color: "grey"       # The color of the goose representing this player
    #
    # Example:
    #
    #     board.add_player(name: 'Samual L. Jackson', age: 52, color: 'purple')
    #
    def add_player(player_or_attributes)
      if player_or_attributes.is_a?(Geese::Player)
        @players << player_or_attributes
      else
        @players << Player.new(player_or_attributes)
      end
    end

    # Returns the player attributes for the player for the current turn
    def current_player
      @current_player_index ||= players.index(youngest_player)
      players[@current_player_index]
    end

    # Returns the number of players
    def number_of_players
      players.size
    end

    # Returns the winning player, if any
    def winning_player
      players.select { |p| p.location == number_of_squares }.first
    end

    def player_with_color(color)
      players.select { |p| p.color == color }.first
    end

    # Process a die-roll for the current user
    def roll_for_current_player(score)
      final_score = final_score_for_current_player_roll(score)
      new_location = move_current_player(final_score)

      return if double_roll_at?(new_location)
      turn_for_current_player
    end

    # Process the turn for the currently active player.
    def turn_for_current_player
      @current_player_index = (@current_player_index + 1) % players.size
    end

    private

    def youngest_player
      players.sort.first
    end

    def final_score_for_current_player_roll(score)
      location = current_player.location
      multiplier = geesified_square_at?(location + score) ? 2 : 1
      score * multiplier
    end

    def move_current_player(score)
      current_player.location = [current_player.location + score, number_of_squares].min
    end

    def initialize(number_of_squares)
      @number_of_squares = number_of_squares
      @geesified_squares = []
      @double_roll_squares = []
      @players = []
    end
  end
end
