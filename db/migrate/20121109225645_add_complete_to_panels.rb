class AddCompleteToPanels < ActiveRecord::Migration
  def change
    add_column :panels, :complete, :boolean, default: false
  end
end
