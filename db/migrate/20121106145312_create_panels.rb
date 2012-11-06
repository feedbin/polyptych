class CreatePanels < ActiveRecord::Migration
  def change
    create_table :panels do |t|
      t.string :hash
      t.timestamps
    end
    add_index :panels, :hash, unique: true
  end
end
