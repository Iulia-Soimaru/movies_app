class CreateMovieLists < ActiveRecord::Migration
  def change
    create_table :movie_lists do |t|
      t.integer :user_id
      t.integer :movie_id
    end
  end
end
