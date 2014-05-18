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

  describe '#double_roll_at, #double_roll_at?' do
    let(:board) { Geese::Board.create_with_number_of_squares(63) }

    it 'has no double-roll squares by default' do
      (1..63).each do |n|
        expect(board.double_roll_at?(n)).to be_false
      end
    end

    it "marks squares as double-roll" do
      expect {
        board.double_roll_at(42)
      }.to change { board.double_roll_at?(42) }.from(false).to(true)
    end
  end

  describe '#geesify_square, #geesified_square_at?' do
    let(:board) { Geese::Board.create_with_number_of_squares(63) }

    it 'has no geesified squares by default' do
      (1..63).each do |n|
        expect(board.geesified_square_at?(n)).to be_false
      end
    end

    it 'marks squares as geesified' do
      expect {
        board.geesify_square_at(42)
      }.to change { board.geesified_square_at?(42) }.from(false).to(true)
    end
  end

  describe '#add_player' do
    let(:board) { Geese::Board.create_with_number_of_squares(63) }

    it 'adds a player to the board' do
      board.add_player(player)
      expect(board).to have(1).players
    end
  end

  describe '#number_of_players' do
    let(:board) { Geese::Board.create_with_number_of_squares(63) }

    it '0 for a new board' do
      expect(board.number_of_players).to eq(0)
    end

    it '1 with a player' do
      expect {
        board.add_player(player)
      }.to change(board, :number_of_players).by(1)
    end
  end

  describe '#winning_player' do
    let(:board) { Geese::Board.create_with_number_of_squares(63) }

    it 'returns nil with no winners' do
      board.add_player(player)
      expect(board.winning_player).to be_nil
    end

    it 'returns the player who is on the last square' do
      winner = player(location: 63)
      board.add_player(winner)
      expect(board.winning_player).to eq(winner)
    end
  end

  describe '#player_with_color' do
    let(:john) { player(name: "John", age: 11, color: 'grey') }
    let(:board) { Geese::Board.create_with_number_of_squares(63) }
    before { board.add_player(john) }

    it 'returns the correct player' do
      expect(board.player_with_color('grey')).to eq(john)
    end
  end

  describe '#roll_for_curent_player' do
    let(:john) { player(name: "John", age: 11, color: 'grey') }
    let(:board) { Geese::Board.create_with_number_of_squares(63) }
    before { board.add_player(john) }

    it 'moves the player forward' do
      expect {
        board.roll_for_current_player(1)
      }.to change(board.current_player, :location).by(1)
    end

    it 'passes the turn to the next player' do
      expect(board).to receive(:turn_for_current_player).once
      board.roll_for_current_player(1)
    end

    it 'does not exceed number_of_squares' do
      expect {
        board.roll_for_current_player(1000)
      }.to change(board.current_player, :location).from(0).to(63)
    end

    it 'moves double when landing on a geesified square' do
      board.geesify_square_at(2)

      expect {
        board.roll_for_current_player(2)
      }.to change(board.current_player, :location).by(4)
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
