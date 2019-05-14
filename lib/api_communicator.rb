require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  arr = []
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  hash_results = response_hash["results"]

  hash_results.collect do |character_hash|
    if character_hash["name"] == character_name
      character_hash["films"].collect do |each_url|

      response_url = RestClient.get(each_url)
      response_hash_film = JSON.parse(response_url)
      arr << response_hash_film
    end
  end

end
arr
end




  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.


def print_movies(films)
  films.each do |film|
  puts  "Movie name: #{film["title"]}"
  end
  # some iteration magic and puts out the movies in a nice list
end



def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end




## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
