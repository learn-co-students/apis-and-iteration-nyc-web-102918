require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  char_data = response_hash["results"].find do |char|
    char["name"] == character
  end
  films = char_data["films"]
  films.map do |film|
    var = RestClient.get(film)
    var2 = JSON.parse(var)
    var2["title"]
  end


  # NOTE: in this demonstration we name many of the variables _hash or _array.
  # This is done for educational purposes. This is not typically done in code.


  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def print_movies(character)
  # some iteration magic and puts out the movies in a nice list
  get_character_movies_from_api(character).each_with_index do |movie, i|
    puts "#{i+1} #{movie}"
  end
end

def show_character_movies(character)
  print_movies(character)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
