def welcome
  puts "Hello, welcome to the Star Wars Character Finder!!!!"# puts out a welcome message here!
end

def get_character_from_user
  puts "please enter a character"
  gets.strip.downcase
  # use gets to capture the user's input. This method should return that input, downcased.
end

def run
	welcome
	character = nil
	loop do
		character = get_character_from_user
		break if character == "exit"

		show_character_movies(character)
	end
	puts "Goodbye!"
end