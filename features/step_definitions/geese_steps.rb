Stel(/^ik heb een speelbord met (\d+) vakjes$/) do |number_of_squares|
  number_of_squares = number_of_squares.to_i
  @board = Geese::Board.create_with_number_of_squares(number_of_squares)
end

Stel(/^ik heb de volgende spelers met de klok mee:$/) do |players|
  players.hashes.each do |h|
    @board.add_player(
      name:  h["naam"],
      age:   h["leeftijd"].to_i,
      color: h["kleur pion"],
    )
  end
end

Stel(/^alle pionnen staan op het startvakje$/) do
  # no-op
end

Stel(/^Piet gooit altijd (\d+) met de dobbelsteen$/) do |score|
  score = score.to_i

  @fixed_scores ||= Hash.new(nil)
  @fixed_scores['piet'] = score.to_i
end

Stel(/^het (\d+)de vakje is een ganzenvakje$/) do |square|
  square = square.to_i
  @board.geesify_square_at(square)
end

Stel(/^op het (\d+)de vakje mag je nogmaals dobbelen$/) do |square|
  square = square.to_i
  @board.double_roll_at(square)
end

Dan(/^is (.*) aan de beurt om te dobbelen omdat hij de jongste speler is$/) do |name|
  expect(@board.current_player[:name]).to eql(name)
end

Als(/^de beurt van (.*) is geweest$/) do |name|
  expect(@board.current_player[:name]).to eql(name)
  @board.turn_for_current_player
end

Dan(/^is (.*) aan de beurt om te dobbelen$/) do |name|
  expect(@board.current_player[:name]).to eql(name)
end

Als(/^(.*) (\d+) dobbelt$/) do |name, score|
  score = score.to_i

  expect(@board.current_player[:name]).to eql(name)
  @board.roll_for_current_player(score)
end

Dan(/^staat de paarse pion op het (\d+)de vakje$/) do |square|
  square = square.to_i
  expect(@board.player_with_color("paars").location).to eql(square)
end

Dan(/^is de bord opstelling als volgt:$/) do |table|
  table.hashes.each do |h|
    expect(@board.player_with_color(h["pion"]).location).to eql(h["vakje"].to_i)
  end
end

Als(/^er (\d+) speelrondes zijn gespeeld$/) do |turns|
  turns = @board.number_of_players * turns.to_i

  turns.times do
    player = @board.current_player
    score  = @fixed_scores[player.name.downcase] || rand(6) + 1
    @board.roll_for_current_player(score)
  end
end

Dan(/^heeft (.*) het spel gewonnen$/) do |name|
  expect(@board.winning_player.name).to eq(name)
end

