class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|

      t.timestamps
      t.text :link
      t.string :name
      t.string :facebookid
    end
  end

  def self.down
    drop_table :links
  end
end
