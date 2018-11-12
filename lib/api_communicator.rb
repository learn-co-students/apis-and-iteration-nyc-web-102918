require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  response_hash["results"].each do |char|
    if char["name"] == character
      return char["films"]
    end
  end
end


def print_movies(films_array)
  # some iteration magic and puts out the movies in a nice list
   films_array.each do |url|
    response_string = RestClient.get(url)
    response_hash = JSON.parse(response_string)
    puts response_hash["title"]
  end
end


def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
