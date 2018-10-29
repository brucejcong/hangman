require_relative 'util.rb'


class Hangman
	include Utilities

	def initialize 
		puts "Starting new game of Hangman!"
		@words_list = []
		File.foreach('5desk.txt') do |word|
			if word.chomp.length >= 5 and word.chomp.length <= 12
				@words_list.push word.chomp
			end
		end
		@answer = @words_list.sample
		puts @answer
		@previous_guesses = []
		play
	end

	def play
		wrong_guesses = 0
		@board = "_"*@answer.length
		until wrong_guesses == 7
			display_board
			puts "You have #{7 - wrong_guesses} guesses left. Please enter a letter. We will take the first letter you enter!"
			letter = gets.chomp[0].downcase
			positions = Utilities.give_positions(@answer.downcase, letter)
			@previous_guesses << letter
			if !positions.empty?	
				puts "Yes! #{positions.length} #{letter}'s"
				positions.each do |pos|
					if pos == 0 and letter != @answer[0]
						@board[pos] = letter.capitalize
					else
						@board[pos] = letter
					end
				end
				if win?
					p "You won!"
					return
				end
			else
				puts "Sorry! There is no #{letter}."
				wrong_guesses += 1
			end
		end
		puts "You lose!"
	end

	def display_board
		puts "Here are the previous guesses:"
		@previous_guesses.each_with_index do |guess, index|
			if index == @previous_guesses.length - 1
				puts guess
			else
				print "#{guess}, "
			end
		end
		puts " "
		p @board
	end

	def win?
		@board.match(/^[[:alpha:]]+$/)
	end

end


game = Hangman.new()
