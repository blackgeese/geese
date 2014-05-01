require 'spec_helper'

describe Geese::Board do

  describe '.create_with_number_of_squares' do
    it 'creates a board with the number of squares' do
      board = Geese::Board.create_with_number_of_squares
      expect(board.number_of_squares).to eq(63)

      board = Geese::Board.create_with_number_of_squares(128)
      expect(board.number_of_squares).to eq(128)
    end
  end


  describe '#add_player' do
    let(:board) { Geese::Board.create_with_number_of_squares(63) }

    it 'adds a player to the board' do
      board.add_player(player_attributes)
      expect(board).to have(1).players
    end
  end

end
