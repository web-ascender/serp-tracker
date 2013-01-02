class CreateSourceReports < ActiveRecord::Migration
  def change
    create_table :source_reports do |t|
      t.belongs_to :website
      t.timestamps
    end
  end
end
