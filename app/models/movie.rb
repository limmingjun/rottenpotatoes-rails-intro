class Movie < ActiveRecord::Base

  def self.movie_ratings
    ['G','PG','PG-13','R']
  end

  def self.with_ratings(ratings)
    if ratings.nil?
      return Movie.all
    end
    Movie.where({rating: ratings.keys})
  end
end
