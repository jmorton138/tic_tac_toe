class Player
    attr_reader :name
    attr_reader :symbol
    attr_accessor :player_score

    def initialize(name, player_num)
        @name = name
        @player_num = player_num
        @player_score = []
        if player_num == 1
            @symbol = "X"
        else
            @symbol = "0"
        end
    end

end

class GameBoard
    attr_accessor :board

    @@victory = false
    @@winning_combos = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

    def initialize
        @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    end

    def render_board
        # loop through and format board array into grid config
        print "\n"
        counter = 1
        board.each do |num|
            print " #{num.to_s} "
            if counter % 3 != 0
                print "|"
            elsif counter % 3 == 0 && counter != 9
                print "\n---+---+---\n"
            end
            counter += 1
        end
        print "\n\n"
    end

    def start_game(player_1, player_2)
        render_board
        counter = 1
        until @@victory == true do
            #ask player 1 for their move
            if counter.odd?
                player_move(player_1)
            #ask player 2 for their move
            else
                player_move(player_2)
            end
            counter +=1
        end
    end

    def player_move(player)
        puts "#{player.name}, your move"
        move = gets.chomp.to_i
        #if player already chose that number send error message and rerun method
        if !board.include?(move)
            puts "Number is unavailable. Try again"
            player_move(player)
        else
            player.player_score.push(move)
            #log score and update gameboard
            update_game(move, player.symbol)
            #check if player has won
            game_status(player)
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

    def game_status(player)
        @@winning_combos.each do |combo|
            if combo.all?  {|num| player.player_score.include?(num)}
                @@victory = true
                puts "#{player.name} wins"
            end
        end 

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
#begin new game
game.start_game(player_1, player_2)



