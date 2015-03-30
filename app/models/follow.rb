class Follow < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :preys, :foreign_key => "user_id", :class_name => "User"
  belongs_to :stalkers, :foreign_key => "stalker_id", :class_name => "User"

end
