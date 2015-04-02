class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :my_rate

      t.timestamps
    end
  end
end
