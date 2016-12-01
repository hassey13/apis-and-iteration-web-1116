require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)

      url_array = get_pages
      films_array = []
      url_array.each do |url|
           puts "Searching database..."
            all_characters = RestClient.get(url)
            character_hash = JSON.parse(all_characters)


            character_hash["results"].each do |char_array|
                  if char_array["name"].downcase == character
                        films_array = char_array["films"]
                  end
            end
      end
      films_array
end

def get_pages
  url = 'http://www.swapi.co/api/people/'
  url_array = []
      while true
            character_page = RestClient.get(url)
            character_hash = JSON.parse(character_page)
            if character_hash["next"]
                  url_array << url
                  url = character_hash["next"]
            else
                url_array << url
                  break
            end
      end
      url_array
end

def get_opening_crawl_from_api(movie_selected)

  all_movie = RestClient.get('http://swapi.co/api/films/')
  movie_hash = JSON.parse(all_movie)

  movie_hash["results"].each do |movie|
    if movie["title"].downcase == movie_selected
      return movie["opening_crawl"]
    end
  end
  "That is not a Star Wars movie!"
end

def get_film_info (films_array)
  if films_array == []
    puts "Your character was not found in Star Wars."
  else
    films_array.collect do |film|
      film_info = RestClient.get(film)
      film_hash = JSON.parse(film_info)
      film_hash["title"]
    end
  end
end

def parse_character_movies(films_hash)
  # used get_film_info instead of this method
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  puts get_film_info(films_hash)

end
