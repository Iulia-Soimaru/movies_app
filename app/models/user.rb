class User < ActiveRecord::Base
  # Remember to create a migration!

  has_many :i_am_following, :class_name => "Follow", :foreign_key => "stalker_id"

  has_many :being_followed_by, :class_name => "Follow", :foreign_key => "user_id"

   has_many :preys, :through => :i_am_following
   has_many :stalkers, :through => :being_followed_by


  has_many :movies, through: :movie_lists
end
