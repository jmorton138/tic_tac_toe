
#You’ll need to make sure the tests that determine victory or loss conditions are correctly assessed.

# Start by writing tests to make sure players win when they should, 
# e.g. when the board reads X X X across the top row, your #game_over method (or its equivalent) should trigger.
require 'rspec'
require_relative '../lib/tic_tac_toe.rb'


describe GameBoard do
    
    
 
    describe "#game_status" do
        subject(:game) { described_class.new } 
        context "when top row (coordinates: 1, 2, 3) are X's" do
            let(:player) { instance_double(Player, name: 'steve', player_num: 1, player_score: [1, 2, 3])}

            it "changes victory variable to true" do
                expect{ game.game_status(player) }.to change { game.instance_variable_get(:@victory) }.from(false).to(true)
            end
        end

        context "when vertical column (coordinates: 3, 6, 9) are X's" do
            let(:player) { instance_double(Player, name: 'joe', player_num: 1, player_score: [3, 6, 9])} 

            it "changes victory variable to true" do
                expect{ game.game_status(player) }.to change { game.instance_variable_get(:@victory) }.from(false).to(true)
            end
        end

        context "when diagonal line (coordinates: 7, 5, 3) are X's" do
            let(:player) { instance_double(Player, name: 'joe', player_num: 1, player_score: [7, 5, 3])} 

            it "changes victory variable to true" do
                expect{ game.game_status(player) }.to change { game.instance_variable_get(:@victory) }.from(false).to(true)
            end
        end

        context "when 3 in row plus other coordinates are on the board" do
            let(:player) { instance_double(Player, name: 'joe', player_num: 1, player_score: [7, 5, 3, 4, 8])} 

            it "changes victory variable to true" do
                expect{ game.game_status(player) }.to change { game.instance_variable_get(:@victory) }.from(false).to(true)
            end
        end

        context "when it's a cat's game" do
            let(:player) { instance_double(Player, name: 'joe', player_num: 1, player_score: [5, 3, 4, 8])} 
            before do
                game.board = ['X', 'X', 'X', 'X', 'X', 'O', 'O', 'O', 'O']
            end
            it "changes victory variable to true without announcing winner" do
                expect{ game.game_status(player) }.to change { game.instance_variable_get(:@victory) }.from(false).to(true)
            end
        end
    end

    describe "#validate_move" do
        subject(:new_game) { described_class.new }

        context "when coordinate is already chosen" do
            let(:new_player) { instance_double(Player, name: 'steve', player_num: 1, player_score: [1]) }
            
            before do
                allow(new_game).to receive(:player_move)
                new_game.board[0] = 'X'
            end

            it "puts error message" do
                expect(new_game).to receive(:puts).with("Number is unavailable. Try again")
                new_game.validate_move(new_player, 1)
            end
            it "continues loop" do
                expect(new_game).to receive(:player_move).with(new_player)
                new_game.validate_move(new_player, 1)
            end
        end
    end

    describe "#player_move" do
        subject(:game_move) { described_class.new }
        
        context "when input is valid" do
            let(:player_1) { instance_double(Player, name: 'steve', player_num: 1, player_score: [1]) }
            
            before do 
                allow(game_move).to receive(:update_game).with(2, 'X')
                allow(player_1).to receive(:symbol)
            end

            it "updates game" do
                
                allow(game_move).to receive(:validate_move).and_return(true)
                expect(game_move).to receive(:update_game)
                game_move.player_move(player_1)
            end
        end
    end


end

#rspec spec/tic_tac_toe_spec.rb

#duplicates error checking
#error loops