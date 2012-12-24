class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :url
      #t.string :path
      #t.string :title
      t.text :html
      t.boolean :analyzed, :default => false
      t.timestamps
    end
  end
end
