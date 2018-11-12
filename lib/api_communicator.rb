require 'rest-client'
require 'json'
require 'pry'

def get_character(character)
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  # character_data = response_hash["results"]
  # character_name = character_data["name"]


  character_data = []


  i = 1
  new_response_string = RestClient.get("https://swapi.co/api/people/?page=#{i}")
  new_response_hash = JSON.parse(new_response_string)

  while !(new_response_hash["next"].nil?)
    new_response_string = RestClient.get("https://swapi.co/api/people/?page=#{i}")
    new_response_hash = JSON.parse(new_response_string)
    character_data.concat(new_response_hash["results"])
    i += 1
  end


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





def get_planet(planet)
  response_string = RestClient.get("http://swapi.co/api/planets/")
  response_hash = JSON.parse(response_string)
  # planet_data = response_hash["results"]
  planet_data = []


  i = 1
  new_response_string = RestClient.get("https://swapi.co/api/planets/?page=#{i}")
  new_response_hash = JSON.parse(new_response_string)

  while !(new_response_hash["next"].nil?)
    new_response_string = RestClient.get("https://swapi.co/api/planets/?page=#{i}")
    new_response_hash = JSON.parse(new_response_string)
    planet_data.concat(new_response_hash["results"])
    i += 1
  end


  # while !(response_hash["next"].nil?)
  #    new_response_string = RestClient.get(response_hash["next"])
  #    new_response_hash = JSON.parse(new_response_string)
  #    planet_data.concat(new_response_hash["results"])
  #    break if new_response_hash["next"].nil?
  # end





  planet_data.find do |planet_hash|
    planet_hash["name"].downcase == planet
  end
end

def get_planet_residents_from_api(planet)
  #make the web request
  planet_data = get_planet(planet)

  residents = []
  planet_data["residents"].each do |resident|
    response_string = RestClient.get(resident)
    response_hash = JSON.parse(response_string)
    residents << response_hash
  end

  residents
end

def print_residents(residents_hash)
  residents_hash.each do |resident|
    puts resident["name"]
  end
end

def show_planet_residents(planet)
  residents_array = get_planet_residents_from_api(planet)
  print_residents(residents_array)
end
