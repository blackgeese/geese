require 'geese'
require 'highline/import'

module Geese
  class Shell

    def self.start!
      Geese::Shell.new.start
    end

    attr_reader :board

    def initialize
    end

    def start
      welcome_message
      create_empty_board

      process_next_command
    end

    def welcome_message
      puts
      puts
      puts "                  ____                     _"
      puts "                 / ___| ___  ___  ___  ___| |"
      puts "                | |  _ / _ \\/ _ \\/ __|/ _ \\ |"
      puts "                | |_| |  __/  __/\\__ \\  __/_|"
      puts "                 \\____|\\___|\\___||___/\\___(_)"
      puts
      puts "                              a BLACK GEESE game."
      puts
      puts "Type `help` for assistance, `exit` to get the hell out of here."
      puts
    end

    def process_next_command
      begin
        inputs = ask(prompt).strip.squeeze(" ").split(" ")
        command = inputs.shift.downcase

        case command
        when "help"
          help
        when "roll"
          roll
        when "status"
          status_report
        when "player"
          player(inputs)
        when "exit"
          say("\nThank you, good night!\n\n")
        else
          cant_do_that
        end
      end while command.strip.downcase != "exit"
    end

    def player(inputs)
      action = inputs.shift

      case action
      when 'add'
        age = inputs.shift.to_i
        color = inputs.shift.downcase
        name = inputs.join(" ")

        board.add_player(name: name, age: age, color: color)
        say("Added a #{color} player #{name}, aged #{age}")
      else
        say("what?")
      end
    end

    def roll
      score = rand(6) + 1

      status("#{board.current_player.name} rolled #{score}", :magenta)

      board.roll_for_current_player(score)

      status_report
    end

    def status_report
      status("There are #{board.number_of_players} player(s).")

      players = []
      board.players.each do |player|
        players << " [%2d] #{player.name}, #{player.color}, #{player.age}" % player.location
      end
      status(players.join("\n"))

      if board.number_of_players > 0
        status("Current turn is for #{board.current_player.name}")
      end
    end

    def help
      say "<%= color('Help is not available at this time.', :red) %>"
    end

    def cant_do_that
      say "I don't know how to do that."
    end

    def create_empty_board
      @board = Geese::Board.create_with_number_of_squares(63)
      status(
        "A new board for a Game of Goose has been created.\n"+
        "Add a new player with `player add <age> <color> <name>`"
      )
    end

    def status(msg, color = :yellow)
      prefix = "  >"

      msg = msg.split("\n").map { |l| "#{prefix} #{l}" }.join("\n")

      say("<%= color('#{msg}', :#{color}) %>")
      say("\n")
    end

    def prompt
      "<%=color('~>', :blue)%> "
    end
  end
end
