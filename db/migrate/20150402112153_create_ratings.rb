class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :rate_value
      t.belongs_to :user
      t.belongs_to :movie

      t.timestamps
    end
  end
end
