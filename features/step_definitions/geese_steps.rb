Stel(/^ik heb een speelbord met (\d+) vakjes$/) do |number_of_squares|
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
