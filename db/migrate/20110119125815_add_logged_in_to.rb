class AddLoggedInTo < ActiveRecord::Migration
  def self.up
	  add_collumn :users, :logged_in,:boolean
  end

  def self.down
	  remove_collumn :users, :logged_in
  end
end
