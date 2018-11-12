require 'rest-client'
require 'json'
require 'pry'

def web_request(url)
  response_string = RestClient.get(url)
  response_hash = JSON.parse(response_string)
  response_hash
end

def get_character_movies_from_api(character)
  #make the web request
  response_hash = web_request('http://www.swapi.co/api/people/')
  films_character = []
  response_hash["results"].each do |character_hash|
    if character_hash["name"].downcase== character
      films_character << character_hash["films"]
    end
  end
  films_character.flatten!

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  films_hash = films_character.map do |url|
    web_request(url)
  end
    films_hash


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
  # some iteration magic and puts out the movies in a nice list
  films_title = films_hash.map do |films|
    films["title"]
  end
  counter = 0
  films_title.each do |title|
    counter +=1
    puts "Title #{counter}: #{title}"
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
