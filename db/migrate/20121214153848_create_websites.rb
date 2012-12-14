class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.belongs_to :client
      t.string :name
      t.string :url
      t.boolean :search_google, :default => true
      t.boolean :search_bing, :default => true
      t.timestamps
    end
  end
end
