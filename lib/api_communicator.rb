require 'rest-client'
require 'json'
require 'pry'

def get_character(character)
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  character_data = response_hash["results"]
  # character_name = character_data["name"]
  character_data.find do |character_hash|
    character_hash["name"].downcase == character
  end
end

def get_character_movies_from_api(character)
  #make the web request
  character_data = get_character(character)

  # movies = []
  #
  # character_data["films"].each do |film|
  #   response_string = RestClient.get(film)
  #   response_hash = JSON.parse(response_string)
  #   movies << response_hash["title"]
  # end
  #
  # movies



  movies = []

  character_data["films"].each do |film|
    response_string = RestClient.get(film)
    response_hash = JSON.parse(response_string)
    movies << response_hash
  end

  movies


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

def print_movies(films_hash)
  films_hash.each do |film|
    puts film["title"]
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
