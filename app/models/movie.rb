class Movie < ActiveRecord::Base
<<<<<<< HEAD
  
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.find_by_director(director)
    Movie.find_all_by_director(director)
  end
  
=======

  @@all_ratings = ['G', 'PG', 'PG-13', 'R']

  def self.get_all_ratings
    @@all_ratings
  end

>>>>>>> heroku/master
end
