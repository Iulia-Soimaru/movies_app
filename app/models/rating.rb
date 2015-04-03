class Rating < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :rated_user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :rated_movie, class_name: 'Movie', foreign_key: 'movie_id'
end
