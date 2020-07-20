require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get("http://www.swapi.co/api/people/?search=#{character}")
  response_hash = JSON.parse(response_string)
  
  # NOTE: in this demonstration we name many of the variables _hash or _array. 
  # This is done for educational purposes. This is not typically done in code.
  char_data = response_hash["results"].first

  get_movies(char_data)
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
  if films_hash.class == String
    puts films_hash 
    return
  end

  films_hash.sort_by{|data| data["release_date"] }.each_with_index do |film, i|
    puts "#{i + 1}. #{film["title"]}"
    puts "  Directed by #{film["director"]}"
    puts "  Produced by #{film["producer"]}"
    puts "  Released #{film["release_date"]}"
    puts film["opening_crawl"][0..150] + "...\n"
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS
def get_movies(char_data)
  return "Invalid character" if char_data.nil?

  char_data["films"].map do |film|
    res = RestClient.get(film)

    JSON.parse(res.body)
  end
end
# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
