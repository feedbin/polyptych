class CreateFavicons < ActiveRecord::Migration
  def change
    create_table :favicons do |t|
      t.string :hostname
      t.string :content_type
      t.text :favicon
      t.timestamps
    end
    add_index :favicons, :hostname, unique: true
  end
end
