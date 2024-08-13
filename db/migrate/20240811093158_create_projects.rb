class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :token, null: false
      t.references :projectable, polymorphic: true, null: false

      t.timestamps
    end

    add_index :projects, :token, unique: true
    add_index :projects, [:projectable_type, :projectable_id]
  end
end
