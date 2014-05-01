$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'geese'

def player_attributes(override = {})
  {
    name:  "Gandalf",
    age:   "341",
    color: "grey",
  }.merge!(override)
end
