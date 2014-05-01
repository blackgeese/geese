Stel(/^ik heb een speelbord met (\d+) vakjes$/) do |number_of_squares|
  @board = Geese::Board.create_with_number_of_squares(number_of_squares)
end

Stel(/^ik heb de volgende spelers met de klok mee:$/) do |players|
  players.hashes.each do |h|
    @board.add_player(
      name:  h["naam"],
      age:   h["age"].to_i,
      color: h["kleur pion"],
    )
  end
end

Stel(/^alle pionnen staan op het startvakje$/) do
end

Dan(/^is Piet aan de beurt om te dobbelen omdat hij de jongste speler is$/) do
  pending # express the regexp above with the code you wish you had
end

Als(/^de beurt van Piet is geweest$/) do
  pending # express the regexp above with the code you wish you had
end

Dan(/^is Klaas aan de beurt om te dobbelen$/) do
  pending # express the regexp above with the code you wish you had
end

Als(/^de beurt van Klaas is geweest$/) do
  pending # express the regexp above with the code you wish you had
end

Dan(/^is Jan aan de beurt om te dobbelen$/) do
  pending # express the regexp above with the code you wish you had
end
