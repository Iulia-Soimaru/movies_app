class MovieList < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  belongs_to :movie
  belongs_to :rating
end
