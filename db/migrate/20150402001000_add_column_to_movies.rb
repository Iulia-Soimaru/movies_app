class AddColumnToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :my_rating, :integer
  end
end
