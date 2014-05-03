class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.integer :map_id

      t.timestamps
    end

    add_index :nodes, :map_id
    add_index :nodes, [:map_id, :name], :unique => true
  end
end
