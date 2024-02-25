# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
  # ["Action", "Comedy", "Drama", "Horror"].each do |list|
  #   MovieGenre.find_or_create_by!(name: list)
  # end

puts "Cleaning DB..."
Movie.destroy_all
puts "Creating movies..."

Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)

require "json"
require 'open-uri'

url = "http://tmdb.lewagon.com/movie/top_rated?language=en-US&page=1"

data = JSON.parse(URI.open(url).read)

MoviesArray = data.values[1]
MoviesArray.map do |m|
  image_url = m["poster_path"]
  final_link = "https://image.tmdb.org/t/p/original#{image_url}"
  # p final_link
  Movie.create(title: m["title"], overview: m["overview"], poster_url: final_link, rating: m["vote_average"])
end

# 🔴 solved problem! --> poster_url for API wasn't working until we inserted the Movie.destroy all:
# REASON?: This approach effectively resets the database to a clean state before inserting new data,
# preventing conflicts with existing records and ensuring data integrity.

# puts "******* only first url here"
# peli = Movie.first
# p peli.poster_url

puts "Finished! Total of #{MoviesArray.count} movies created!"
