module Geese
  # A fancy Hash that represents a Player
  class Player < Hashie::Dash
     property :name,        required: true
     property :age,         required: true
     property :color,       required: true
     property :location,    required: true, default: 0

     def ==(other)
       self.color == other.color
     end

     def <=>(other)
       age <=> other.age
     end
  end
end
