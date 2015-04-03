class Movie < ActiveRecord::Base
  # Remember to create a migration!
has_many :movie_lists
has_many :users, through: :movie_lists

has_many :ratings
has_many :rated_users, through: :ratings
end
