class CreateKeywordResults < ActiveRecord::Migration
  def change
    add_column :keywords, :position, :integer
    create_table :keyword_results do |t|
      t.belongs_to :keyword
      t.string :search_engine
      t.integer :position
      t.text :html
      t.timestamps
    end
  end
end
