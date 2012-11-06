class FixHashName < ActiveRecord::Migration
  def self.up
    remove_index :panels, :hash
    rename_column :panels, :hash, :name
    add_index :panels, :name, unique: true
  end

  def self.down
    remove_index :panels, :name
    rename_column :panels, :name, :hash
    add_index :panels, :hash, unique: true
  end
end
