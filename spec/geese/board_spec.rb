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
      board.add_player(player)
      expect(board).to have(1).players
    end
  end

  describe '#turn_for_current_player' do
    let(:john) { player(name: "John", age: 11, color: 'grey') }
    let(:jane) { player(name: "Jane", age: 9, color: 'green') }

    let(:board) { Geese::Board.create_with_number_of_squares(63) }

    before do
      board.add_player(john)
      board.add_player(jane)
    end

    it 'progresses turn to next player' do
      expect {
        board.turn_for_current_player
      }.to change(board, :current_player).from(jane).to(john)
    end
  end

  describe '#current_player' do
    let(:john) { player(name: "John", age: 11, color: 'grey') }
    let(:jane) { player(name: "Jane", age: 9, color: 'green') }

    let(:board) { Geese::Board.create_with_number_of_squares(63) }

    before do
      board.add_player(john)
      board.add_player(jane)
    end

    it 'chooses youngest player to start' do
      expect(board.current_player).to eq(jane)
    end
  end
end
