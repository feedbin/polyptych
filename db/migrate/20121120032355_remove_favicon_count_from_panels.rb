class RemoveFaviconCountFromPanels < ActiveRecord::Migration
  def up
    remove_column :panels, :favicon_count
  end

  def down
    add_column :panels, :favicon_count, :integer, default: 0
  end
end
