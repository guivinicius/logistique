class CreateEdges < ActiveRecord::Migration
  def change
    create_table :edges do |t|
      t.integer :source
      t.integer :target
      t.float :cost
      t.integer :map_id

      t.timestamps
    end
    add_index :edges, :map_id
  end
end
