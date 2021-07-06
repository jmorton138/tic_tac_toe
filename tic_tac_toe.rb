class Player
    attr_reader :name
    attr_reader :symbol
    def initialize(name, player_num)
        @name = name
        @player_num = player_num
        if player_num == 1
            @symbol = "X"
        else
            @symbol = "O"
        end
    end

end

class GameBoard
    @@victory = false
    attr_accessor :board
    def initialize
        @board = [1, 2, 3, 4, 5, 6]
        
    end

    def render_board
        # loop through and format board array into grid config
        board.each {|num| puts num.to_s + "|"}
    end

    def player_move
        until @@victory == true do
            puts "Player 1, you're move"
            player_1_move = gets.chomp.to_i
            update_game(player_1_move, "X")
        end
    end
    #after player makes move, render new board
    def update_game(move, symbol)
        board.map! do |i|
            if move == i
                i = symbol
                #board[i - 1] = symbol
            else
                i = i
            end  
        end
        render_board
    end
end



#create player 1
puts "Player 1, choose your name"
player_1 = gets.chomp
player_1 = Player.new(player_1, 1)
puts "#{player_1.name}, you are #{player_1.symbol}'s"
#create player 2
puts "Player 2, choose your name"
player_2 = gets.chomp
player_2 = Player.new(player_2, 2)
puts "#{player_2.name}, you are #{player_2.symbol}'s"
#render gameboard
game = GameBoard.new
game.player_move
#game.update_game(move, player)
#game.render_board
#ask player 1 for their move
#log score and update gameboard
#ask player 2 for their move
#log score and update gameboard
