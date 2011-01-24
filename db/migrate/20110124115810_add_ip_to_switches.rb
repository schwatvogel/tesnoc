class AddIpToSwitches < ActiveRecord::Migration
  def self.up
    add_column :switches, :ip, :string
    add_index :switches, :name, :unique => true
  end

  def self.down
    remove_column :switches, :ip
  end
end
