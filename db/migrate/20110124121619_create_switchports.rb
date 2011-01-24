class CreateSwitchports < ActiveRecord::Migration
  def self.up
    create_table :switchports do |t|
      t.string :name
      t.integer :switch_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :switchports
  end
end
