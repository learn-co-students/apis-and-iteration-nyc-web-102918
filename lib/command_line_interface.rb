def welcome
  # puts out a welcome message here!
  puts "Welcome to Star Wars API"
end

def help
  puts "type c for character"
  puts "type p for planet"
end

def search_type
  input = gets.chomp.downcase
  if input == "c"
    character = get_character_from_user
    show_character_movies(character)
  elsif input == "p"
    planet = get_planet_from_user
    show_planet_residents(planet)
  else
    puts "Please enter valid letter"
    help
  end
end

def get_character_from_user
  puts "please enter a character"
  # use gets to capture the user's input. This method should return that input, downcased.
  (gets.chomp).downcase
end

def get_planet_from_user
  puts "please enter a planet"
  (gets.chomp).downcase
end
