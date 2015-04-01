class CreateMovieLists < ActiveRecord::Migration
  def change
    create_table :movie_lists do |t|
      t.references :user
      t.references :movie
    end
  end
end
