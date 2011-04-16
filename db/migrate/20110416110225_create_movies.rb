class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|

      t.timestamps
      t.string :titlu
      t.text :link
    end
  end

  def self.down
    drop_table :movies
  end
end
