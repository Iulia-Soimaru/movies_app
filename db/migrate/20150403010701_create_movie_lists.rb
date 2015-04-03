class CreateMovieLists < ActiveRecord::Migration
  def change
    create_table :movie_lists do |t|
      t.belongs_to :user
      t.belongs_to :movie
    end
  end
end
