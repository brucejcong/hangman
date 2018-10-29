module Utilities
	def self.give_positions(word, letter)
		positions = []
		word.each_char.with_index do |char, pos|
			if char == letter
				positions << pos
			end
		end
		positions
	end

	def self.check_if_all_letters(string)
		string.match(/^[[:alpha:]]+$/)
	end
end

