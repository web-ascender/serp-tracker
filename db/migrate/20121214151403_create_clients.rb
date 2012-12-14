class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.belongs_to :user
      t.string :name
      t.string :description
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone
      t.timestamps
    end
  end
end
