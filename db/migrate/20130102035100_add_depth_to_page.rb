class AddDepthToPage < ActiveRecord::Migration
  def change
    add_column :pages, :depth, :integer, :default => 0
  end
end
