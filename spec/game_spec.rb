require_relative "../game.rb"
describe "The game"  do
	let(:game){Hangman.new}
	it "Checks that the array has no less than 5 and no more than 12" do
		word = game.instance_variable_get(:@word)
		expect(word.length).to be_between(5, 12).inclusive
	end
	it "Checks the win conditions" do
		turns = 7
		expect(game.check_win).to be(true)
		guesses = 4
		expect(game.check_win).to be(true)
	end
	it "Checks stub" do
		class Game
			attr_accessor :turn
		end
		dbl = "Bane"
		game2 = Game.new
		allow(game2).to receive(:turn).and_return(7)
		expect(game2.turn).to be(7)
	end
end