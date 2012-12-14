class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.belongs_to :website
      t.string :keyword_phrase

      t.timestamps
    end
  end
end
