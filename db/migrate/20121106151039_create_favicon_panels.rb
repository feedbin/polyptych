class CreateFaviconPanels < ActiveRecord::Migration
  def change
    create_table :favicon_panels do |t|
      t.integer :favicon_id
      t.integer :panel_id

      t.timestamps
    end
    add_index :favicon_panels, :favicon_id
    add_index :favicon_panels, :panel_id
    add_index :favicon_panels, [:favicon_id, :panel_id], unique: true
  end
end
