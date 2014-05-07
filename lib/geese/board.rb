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

    # Process the turn for the currently active player.
    def turn_for_current_player
      @current_player_index = (@current_player_index + 1) % players.size
    end

    private

    def youngest_player
      players.sort.first
    end

    def initialize(number_of_squares)
      @number_of_squares = number_of_squares
      @players = []
    end
  end
end
