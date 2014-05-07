$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'geese'

def player(override = {})
  Geese::Player.new(player_attributes(override))
end

def player_attributes(override = {})
  {
    name:  "Gandalf",
    age:   "341",
    color: "grey",
  }.merge!(override)
end
