require "yaml"
class Hangman
	def initialize
		@misses = 0
		@guesses = 0
		@turns = 0
		@letters = []
		@grid = nil
		introduction
		solved = false
	end
	def introduction
		puts "Welcome to Hangman! Would you like to load an old save game or start a new one? "
		print "Enter y or n: "
		input = gets.chomp
		answer = input.strip.downcase
		if answer == "y"
			load_game
		elsif answer == "n"
			load_word
		else
			puts "Please enter only y or n"
		end
	end
	def load_word
		lines = ""
		file = File.open("support/5desk.txt", 'r')
		lines = file.read
		file.close
		valid = lines.split.select {|word| word.length.between?(5,12)}
		@word = valid[rand(valid.size)].downcase.split('')
		show
		game
	end
	def show
		puts "Word is #{@word}"
		@word.collect do |f|
			f = "-" unless @letters.include?(f)
			if f != "-"
				solved = true
			end
			print "#{ f }"
		end
	end
	def game
		print "Guess the word: "
		until @turns == 7
			input = gets.chomp
			if input.strip == "save"
				save_game
			end
			letter = input.downcase.strip
			@word.each do |f|
				if letter == f
					@letters << letter
					@guesses += 1
					puts "Gueses #{@guesses}"
				end
			end
			@turns += 1
			puts "#{@turns}"
			show
			check_win
	   end
	end
	def check_win
		case
		when @turns >= 8
			puts "Your gueeses ended"
			exit!
		when @guesses >= @word.length - 2
			puts "You did it!"
			exit!
		end
	end
	def save_game
		game = { turns: @turns, 
           		   guesses: @guesses,
                   word: @word,
                   letters: @letters 
                  }
        print "Enter the name of the file: "
        input = gets.chomp
        answer = input.strip
		File.open("./saved_games/#{answer}.yml", "w") { |file| file.write(game.to_yaml) }
	end
	def load_game
		puts Dir["./saved_games/**/*.yml"]
		puts "What is your saved file's name? "
		input = gets.chomp
		answer = input.strip
		recipe_from_yaml_file = YAML.load(File.read("./saved_games/#{answer}.yml"))
		@turns = recipe_from_yaml_file[:turns]
		@word = recipe_from_yaml_file[:word]
		@letters = recipe_from_yaml_file[:letters]
		@guesses = recipe_from_yaml_file[:guesses]
		game

	end
end
game = Hangman.new
