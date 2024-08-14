class CreateEnvironments < ActiveRecord::Migration[7.0]
  def change
    create_table :environments do |t|
      t.string :name, null: false
      t.string :token, null: false
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end

    add_index :environments, :token, unique: true
  end
end
