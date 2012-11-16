class AddFaviconCountToPanels < ActiveRecord::Migration
  def change
    add_column :panels, :favicon_count, :integer, default: 0
  end
end
